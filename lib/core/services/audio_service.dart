import 'package:media_kit/media_kit.dart';
import '../models/track.dart' as models;

/// Service for audio playback using media_kit
class AudioService {
  late final Player _player;
  
  AudioService() {
    _player = Player();
  }

  Player get player => _player;

  /// Current playback position
  Stream<Duration> get positionStream => _player.stream.position;

  /// Current playback duration
  Stream<Duration> get durationStream => _player.stream.duration;

  /// Current playback state
  Stream<bool> get playingStream => _player.stream.playing;

  /// Current volume (0.0 to 1.0)
  Stream<double> get volumeStream => _player.stream.volume;

  /// Buffering stream
  Stream<bool> get bufferingStream => _player.stream.buffering;

  /// Completed stream - fires when track ends
  Stream<bool> get completedStream => _player.stream.completed;

  /// Current position
  Duration get position => _player.state.position;

  /// Current duration
  Duration get duration => _player.state.duration;

  /// Is currently playing
  bool get isPlaying => _player.state.playing;

  /// Current volume
  double get volume => _player.state.volume;

  /// Play a track
  Future<void> play(models.Track track) async {
    await _player.open(Media(track.path));
  }

  /// Play from a list of tracks starting at index
  Future<void> playPlaylist(List<models.Track> tracks, int startIndex) async {
    if (tracks.isEmpty) return;
    
    final playlist = Playlist(
      tracks.map((t) => Media(t.path)).toList(),
      index: startIndex,
    );
    
    await _player.open(playlist);
  }

  /// Resume playback
  Future<void> resume() async {
    await _player.play();
  }

  /// Pause playback
  Future<void> pause() async {
    await _player.pause();
  }

  /// Toggle play/pause
  Future<void> playPause() async {
    await _player.playOrPause();
  }

  /// Stop playback
  Future<void> stop() async {
    await _player.stop();
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Skip to next track
  Future<void> next() async {
    await _player.next();
  }

  /// Skip to previous track
  Future<void> previous() async {
    await _player.previous();
  }

  /// Jump to specific index in playlist
  Future<void> jumpTo(int index) async {
    await _player.jump(index);
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0) * 100);
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    await _player.setRate(speed);
  }

  /// Get current playlist index
  Stream<int?> get playlistIndexStream => _player.stream.playlist.map((p) => p.index);

  /// Get current playlist
  Stream<List<Media>> get playlistStream => _player.stream.playlist.map((p) => p.medias);

  /// Dispose the player
  Future<void> dispose() async {
    await _player.dispose();
  }
}