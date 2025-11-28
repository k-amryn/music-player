import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:metadata_god/metadata_god.dart';
import '../models/track.dart';
import '../services/audio_service.dart';

/// The "currently playing" universal state provider
/// This provides the currently playing track, queue, and playback controls
class AudioProvider extends ChangeNotifier {
  final AudioService _audioService;
  
  // Current state
  Track? _currentTrack;
  List<Track> _queue = [];
  int _currentIndex = -1;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;
  bool _isBuffering = false;
  double _volume = 1.0;

  // Stream subscriptions
  final List<StreamSubscription> _subscriptions = [];

  AudioProvider(this._audioService) {
    _initStreams();
  }

  void _initStreams() {
    _subscriptions.add(
      _audioService.positionStream.listen((position) {
        _position = position;
        notifyListeners();
      }),
    );

    _subscriptions.add(
      _audioService.durationStream.listen((duration) {
        _duration = duration;
        notifyListeners();
      }),
    );

    _subscriptions.add(
      _audioService.playingStream.listen((playing) {
        _isPlaying = playing;
        notifyListeners();
      }),
    );

    _subscriptions.add(
      _audioService.bufferingStream.listen((buffering) {
        _isBuffering = buffering;
        notifyListeners();
      }),
    );

    _subscriptions.add(
      _audioService.volumeStream.listen((volume) {
        _volume = volume / 100;
        notifyListeners();
      }),
    );

    _subscriptions.add(
      _audioService.playlistIndexStream.listen((index) {
        if (index != null && index >= 0 && index < _queue.length) {
          _currentIndex = index;
          _updateCurrentTrack(_queue[index]);
        }
      }),
    );

    _subscriptions.add(
      _audioService.completedStream.listen((completed) {
        if (completed && _currentIndex < _queue.length - 1) {
          // Auto-advance handled by media_kit playlist
        }
      }),
    );
  }

  // Getters
  Track? get currentTrack => _currentTrack;
  List<Track> get queue => _queue;
  int get currentIndex => _currentIndex;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isPlaying => _isPlaying;
  bool get isBuffering => _isBuffering;
  double get volume => _volume;
  bool get hasNext => _currentIndex < _queue.length - 1;
  bool get hasPrevious => _currentIndex > 0;

  /// Play a single track
  Future<void> playTrack(Track track) async {
    _queue = [track];
    _currentIndex = 0;
    _updateCurrentTrack(track);
    await _audioService.play(track);
  }

  /// Play a list of tracks starting at the given index
  Future<void> playTracks(List<Track> tracks, {int startIndex = 0}) async {
    if (tracks.isEmpty) return;
    
    _queue = List.from(tracks);
    _currentIndex = startIndex.clamp(0, tracks.length - 1);
    _updateCurrentTrack(_queue[_currentIndex]);
    
    await _audioService.playPlaylist(tracks, _currentIndex);
  }

  /// Add tracks to the end of the queue
  void addToQueue(List<Track> tracks) {
    _queue.addAll(tracks);
    notifyListeners();
  }

  /// Insert tracks after the current track
  void playNext(List<Track> tracks) {
    final insertIndex = _currentIndex + 1;
    _queue.insertAll(insertIndex.clamp(0, _queue.length), tracks);
    notifyListeners();
  }

  /// Remove a track from the queue
  void removeFromQueue(int index) {
    if (index < 0 || index >= _queue.length) return;
    
    _queue.removeAt(index);
    
    if (index < _currentIndex) {
      _currentIndex--;
    } else if (index == _currentIndex) {
      if (_queue.isEmpty) {
        _currentTrack = null;
        _currentIndex = -1;
        _audioService.stop();
      } else {
        _currentIndex = _currentIndex.clamp(0, _queue.length - 1);
        _updateCurrentTrack(_queue[_currentIndex]);
      }
    }
    notifyListeners();
  }

  /// Clear the queue
  void clearQueue() {
    _queue.clear();
    _currentTrack = null;
    _currentIndex = -1;
    _audioService.stop();
    notifyListeners();
  }

  /// Move a track in the queue
  void reorderQueue(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= _queue.length) return;
    if (newIndex < 0 || newIndex >= _queue.length) return;
    
    final track = _queue.removeAt(oldIndex);
    _queue.insert(newIndex, track);
    
    // Adjust current index
    if (oldIndex == _currentIndex) {
      _currentIndex = newIndex;
    } else if (oldIndex < _currentIndex && newIndex >= _currentIndex) {
      _currentIndex--;
    } else if (oldIndex > _currentIndex && newIndex <= _currentIndex) {
      _currentIndex++;
    }
    notifyListeners();
  }

  /// Skip to a specific track in the queue
  Future<void> skipToTrack(int index) async {
    if (index < 0 || index >= _queue.length) return;
    
    _currentIndex = index;
    _updateCurrentTrack(_queue[index]);
    
    await _audioService.jumpTo(index);
  }

  /// Play/pause toggle
  Future<void> playPause() async {
    await _audioService.playPause();
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _audioService.seek(position);
  }

  /// Skip to next track
  Future<void> next() async {
    if (!hasNext) return;
    await _audioService.next();
  }

  /// Skip to previous track
  Future<void> previous() async {
    // If more than 3 seconds into track, restart it
    if (_position.inSeconds > 3) {
      await seek(Duration.zero);
      return;
    }
    
    if (!hasPrevious) {
      await seek(Duration.zero);
      return;
    }
    
    await _audioService.previous();
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _audioService.setVolume(volume);
  }

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _audioService.dispose();
    super.dispose();
  }

  Future<void> _updateCurrentTrack(Track track) async {
    // Set initial track state
    _currentTrack = track;
    notifyListeners();

    // If we already have album art, don't look for it again
    if (track.albumArtPath != null || track.albumArtBytes != null) {
      return;
    }

    // 1. Try to read embedded metadata
    try {
      final metadata = await MetadataGod.readMetadata(file: track.path);
      
      Uint8List? artBytes;
      if (metadata.picture != null) {
        artBytes = metadata.picture!.data;
      }

      final updatedTrack = track.copyWith(
        title: metadata.title ?? track.title,
        artist: metadata.artist ?? track.artist,
        album: metadata.album ?? track.album,
        year: metadata.year,
        genre: metadata.genre,
        trackNumber: metadata.trackNumber,
        discNumber: metadata.discNumber,
        albumArtBytes: artBytes,
      );

      // If we found embedded art, use it
      if (artBytes != null) {
        _currentTrack = updatedTrack;
        notifyListeners();
        return;
      }
      
      // If no embedded art, continue to look for external file
      _currentTrack = updatedTrack;
    } catch (e) {
      debugPrint('Error reading metadata: $e');
      // Continue to look for external file if metadata read fails
      _currentTrack = track;
    }

    // 2. Look for cover art in the same directory
    final coverPath = await _findCoverArt(track.path);
    
    if (coverPath != null) {
      _currentTrack = _currentTrack!.copyWith(albumArtPath: coverPath);
      notifyListeners();
    }
  }

  Future<String?> _findCoverArt(String trackPath) async {
    try {
      final directory = Directory(p.dirname(trackPath));
      if (!await directory.exists()) return null;

      final coverNames = [
        'cover.jpg', 'cover.png', 'cover.webp', 'cover.jpeg',
        'folder.jpg', 'folder.png', 'folder.webp', 'folder.jpeg',
        'album.jpg', 'album.png', 'album.webp', 'album.jpeg',
      ];

      await for (final entity in directory.list()) {
        if (entity is File) {
          final name = p.basename(entity.path).toLowerCase();
          if (coverNames.contains(name)) {
            return entity.path;
          }
        }
      }
    } catch (e) {
      debugPrint('Error finding cover art: $e');
    }
    return null;
  }
}