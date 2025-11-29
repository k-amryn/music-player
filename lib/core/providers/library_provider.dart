import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import '../models/library_folder.dart';
import '../models/track.dart';
import '../database/database.dart';
import '../services/library_database_service.dart';
import '../services/metadata_scanner_service.dart';

/// Provider for browsing the music library
class LibraryProvider extends ChangeNotifier {
  final LibraryDatabaseService _dbService = LibraryDatabaseService.instance;
  final MetadataScannerService _scannerService = MetadataScannerService.instance;
  
  // Supported audio file extensions
  static const Set<String> supportedExtensions = {
    '.mp3', '.flac', '.wav', '.aac', '.m4a', '.ogg', '.wma', '.opus', '.aiff',
  };

  bool _hasPermission = false;
  bool _isScanning = false;
  ScanProgress? _scanProgress;
  StreamSubscription<ScanProgress>? _scanSubscription;

  // Search state
  String _searchQuery = '';
  List<LibraryItem> _searchResults = [];
  bool _isSearching = false;

  bool get isScanning => _isScanning;
  ScanProgress? get scanProgress => _scanProgress;
  String get searchQuery => _searchQuery;
  List<LibraryItem> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  /// Request storage permissions
  Future<bool> requestPermissions() async {
    if (!Platform.isAndroid && !Platform.isIOS) return true;
    
    if (_hasPermission) return true;

    // Request audio permission for Android 13+
    if (await Permission.audio.request().isGranted) {
      _hasPermission = true;
      return true;
    }
    
    // Fallback for older Android versions
    if (await Permission.storage.request().isGranted) {
      _hasPermission = true;
      return true;
    }

    // Check for manage external storage (Android 11+)
    if (await Permission.manageExternalStorage.request().isGranted) {
      _hasPermission = true;
      return true;
    }

    return false;
  }

  /// Initialize the database
  Future<void> initialize() async {
    await _dbService.initialize();
  }

  /// Get items in a directory, with metadata from database if available
  Future<List<LibraryItem>> getDirectoryContents(String path) async {
    try {
      // Ensure we have permission on mobile
      if ((Platform.isAndroid || Platform.isIOS) && !_hasPermission) {
        final granted = await requestPermissions();
        if (!granted) {
          debugPrint('Storage permission denied');
          return [];
        }
      }

      final directory = Directory(path);
      if (!await directory.exists()) {
        return [];
      }

      final items = <LibraryItem>[];
      
      await for (final entity in directory.list()) {
        final name = p.basename(entity.path);
        
        // Skip hidden files
        if (name.startsWith('.')) continue;
        
        if (entity is Directory) {
          // Check database for folder metadata (includes propagated cover art)
          final folderEntity = await _dbService.getFolderByPath(entity.path);
          
          Uint8List? coverArtBytes;
          if (folderEntity != null && folderEntity.coverArtPath != null) {
            coverArtBytes = await _loadCoverArtFromPath(folderEntity.coverArtPath!);
          }
          
          // Only do fallback search if not scanned yet (no folder entity)
          // This avoids redundant recursive searches during normal navigation
          if (coverArtBytes == null && folderEntity == null) {
            coverArtBytes = await _findFolderCoverArtQuick(entity.path);
          }
          
          items.add(LibraryItem(
            path: entity.path,
            name: name,
            isDirectory: true,
            coverArt: coverArtBytes,
          ));
        } else if (entity is File) {
          final extension = p.extension(entity.path).toLowerCase();
          if (supportedExtensions.contains(extension)) {
            // Check database for track metadata
            final trackEntity = await _dbService.getTrackByPath(entity.path);
            
            final stat = await entity.stat();
            items.add(LibraryItem(
              path: entity.path,
              name: trackEntity?.title ?? name,
              isDirectory: false,
              modifiedDate: stat.modified,
              durationMs: trackEntity?.durationMs,
              artist: trackEntity?.artist,
              album: trackEntity?.album,
            ));
          }
        }
      }

      // Sort: directories first, then files, alphabetically
      items.sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return items;
    } catch (e) {
      debugPrint('Error reading directory: $e');
      return [];
    }
  }

  /// Load cover art from a path (either image file or embedded in audio file)
  Future<Uint8List?> _loadCoverArtFromPath(String coverArtPath) async {
    try {
      // Check if it's an image file
      final ext = p.extension(coverArtPath).toLowerCase();
      if (['.jpg', '.jpeg', '.png', '.webp', '.gif'].contains(ext)) {
        final file = File(coverArtPath);
        if (await file.exists()) {
          return await file.readAsBytes();
        }
      }
      
      // It's a track path - try to load embedded art
      if (supportedExtensions.contains(ext)) {
        final metadata = await MetadataGod.readMetadata(file: coverArtPath);
        if (metadata.picture?.data != null) {
          return Uint8List.fromList(metadata.picture!.data);
        }
      }
    } catch (e) {
      debugPrint('Error loading cover art from $coverArtPath: $e');
    }
    
    return null;
  }

  /// Get all tracks in a directory (including subdirectories)
  Future<List<Track>> getAllTracksInDirectory(String path) async {
    final tracks = <Track>[];
    
    try {
      // Try to get from database first
      final dbTracks = await _dbService.getTracksInFolderRecursive(path);
      
      if (dbTracks.isNotEmpty) {
        // Convert TrackEntity to Track
        for (final entity in dbTracks) {
          tracks.add(_trackEntityToTrack(entity));
        }
      } else {
        // Fallback to file system
        final directory = Directory(path);
        if (!await directory.exists()) return tracks;

        await for (final entity in directory.list(recursive: true)) {
          if (entity is File) {
            final extension = p.extension(entity.path).toLowerCase();
            if (supportedExtensions.contains(extension)) {
              tracks.add(Track.fromPath(entity.path));
            }
          }
        }
      }

      // Sort by path
      tracks.sort((a, b) => a.path.compareTo(b.path));
    } catch (e) {
      debugPrint('Error getting tracks: $e');
    }

    return tracks;
  }

  /// Get tracks from a list of files in a directory (non-recursive)
  Future<List<Track>> getTracksInDirectory(String path) async {
    final tracks = <Track>[];
    
    try {
      // Try to get from database first
      final dbTracks = await _dbService.getTracksInFolder(path);
      
      if (dbTracks.isNotEmpty) {
        for (final entity in dbTracks) {
          tracks.add(_trackEntityToTrack(entity));
        }
      } else {
        // Fallback to items
        final items = await getDirectoryContents(path);
        for (final item in items) {
          if (!item.isDirectory) {
            tracks.add(Track.fromPath(item.path));
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting tracks: $e');
    }
    
    return tracks;
  }

  /// Convert TrackEntity to Track
  Track _trackEntityToTrack(TrackEntity entity) {
    return Track(
      id: entity.id.toString(),
      path: entity.path,
      title: entity.title,
      artist: entity.artist,
      album: entity.album,
      duration: entity.duration ?? Duration.zero,
      trackNumber: entity.trackNumber,
      discNumber: entity.discNumber,
      genre: entity.genre,
      year: entity.year,
    );
  }

  /// Check if a path exists
  Future<bool> pathExists(String path) async {
    return await Directory(path).exists() || await File(path).exists();
  }

  /// Get the parent directory path
  String? getParentPath(String path) {
    final parent = p.dirname(path);
    if (parent == path) return null;
    return parent;
  }

  /// Get just the name from a path
  String getFileName(String path) {
    return p.basename(path);
  }

  /// Quick cover art search - only checks immediate folder (no recursion)
  /// Used as fallback for folders not yet in the database
  Future<Uint8List?> _findFolderCoverArtQuick(String folderPath) async {
    final directory = Directory(folderPath);
    
    try {
      if (!await directory.exists()) return null;

      // Check for cover files in this folder only
      final coverNames = [
        'cover.jpg', 'cover.png', 'cover.webp', 'cover.jpeg',
        'folder.jpg', 'folder.png', 'folder.webp', 'folder.jpeg',
        'album.jpg', 'album.png', 'album.webp', 'album.jpeg',
        'front.jpg', 'front.png', 'front.webp', 'front.jpeg',
      ];
      
      await for (final entity in directory.list()) {
        if (entity is File) {
          final name = p.basename(entity.path).toLowerCase();
          if (coverNames.contains(name)) {
            return await entity.readAsBytes();
          }
        }
      }

      // Check first audio file for embedded art
      await for (final entity in directory.list()) {
        if (entity is File) {
          final extension = p.extension(entity.path).toLowerCase();
          if (supportedExtensions.contains(extension)) {
            try {
              final metadata = await MetadataGod.readMetadata(file: entity.path);
              if (metadata.picture?.data != null) {
                return Uint8List.fromList(metadata.picture!.data);
              }
            } catch (e) {
              debugPrint('Error reading embedded art from ${entity.path}: $e');
            }
            break;
          }
        }
      }
    } catch (e) {
      debugPrint('Error finding folder cover art: $e');
    }

    return null;
  }

  /// Scan library folders
  Future<void> scanLibrary(List<String> folderPaths) async {
    if (_isScanning) return;
    if (folderPaths.isEmpty) {
      debugPrint('No folders to scan');
      return;
    }
    
    // Request permissions on Android/iOS before scanning
    if (Platform.isAndroid || Platform.isIOS) {
      final granted = await requestPermissions();
      if (!granted) {
        debugPrint('Storage permission denied - cannot scan library');
        return;
      }
    }
    
    debugPrint('Starting library scan for ${folderPaths.length} folders');
    
    _isScanning = true;
    _scanProgress = null;
    notifyListeners();
    
    _scanSubscription = _scannerService.scanLibraryFolders(folderPaths).listen(
      (progress) {
        _scanProgress = progress;
        notifyListeners();
        
        if (progress.isComplete) {
          _isScanning = false;
          notifyListeners();
        }
      },
      onError: (error, stackTrace) {
        debugPrint('Scan error: $error');
        debugPrint('Stack trace: $stackTrace');
        _isScanning = false;
        notifyListeners();
      },
      onDone: () {
        _isScanning = false;
        notifyListeners();
      },
    );
  }

  /// Cancel ongoing scan
  void cancelScan() {
    _scanSubscription?.cancel();
    _isScanning = false;
    _scanProgress = null;
    notifyListeners();
  }

  /// Refresh metadata for a folder
  Future<void> refreshMetadata(String path) async {
    await _scannerService.refreshFolder(path);
    notifyListeners();
  }

  /// Clear the database cache
  Future<void> clearCache() async {
    await _dbService.clearDatabase();
    notifyListeners();
  }

  /// Get database statistics
  Future<Map<String, int>> getDatabaseStats() async {
    return await _dbService.getStats();
  }

  /// Search library (folders and tracks), optionally scoped to a path
  Future<void> searchLibrary(String query, {String? searchPath}) async {
    debugPrint('LibraryProvider.searchLibrary: $query (path: $searchPath)');
    if (query.isEmpty) {
      _searchQuery = '';
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _searchQuery = query;
    _isSearching = true;
    notifyListeners();

    try {
      // Search folders
      final folderEntities = await _dbService.searchFolders(query, searchPath: searchPath);
      debugPrint('Found ${folderEntities.length} folders');
      final folderItems = <LibraryItem>[];
      
      for (final folder in folderEntities) {
        Uint8List? coverArtBytes;
        if (folder.coverArtPath != null) {
          coverArtBytes = await _loadCoverArtFromPath(folder.coverArtPath!);
        }
        
        folderItems.add(LibraryItem(
          path: folder.path,
          name: folder.name,
          isDirectory: true,
          coverArt: coverArtBytes,
        ));
      }

      // Search tracks
      final trackEntities = await _dbService.searchTracks(query, searchPath: searchPath);
      debugPrint('Found ${trackEntities.length} tracks');
      
      // Group tracks by folder
      final tracksByFolder = <String, List<TrackEntity>>{};
      for (final track in trackEntities) {
        if (!tracksByFolder.containsKey(track.folderPath)) {
          tracksByFolder[track.folderPath] = [];
        }
        tracksByFolder[track.folderPath]!.add(track);
      }

      // Process tracks and collapse into folders if needed
      final processedTrackItems = <LibraryItem>[];
      final existingFolderPaths = folderItems.map((f) => f.path).toSet();

      for (final entry in tracksByFolder.entries) {
        final folderPath = entry.key;
        final tracks = entry.value;

        // If folder is already in results, skip tracks (user sees the folder)
        if (existingFolderPaths.contains(folderPath)) {
          continue;
        }

        // If we have multiple tracks from the same folder (threshold: > 2), show folder instead
        if (tracks.length > 2) {
          // Fetch folder entity to show instead of tracks
          final folderEntity = await _dbService.getFolderByPath(folderPath);
          
          if (folderEntity != null) {
            Uint8List? coverArtBytes;
            if (folderEntity.coverArtPath != null) {
              coverArtBytes = await _loadCoverArtFromPath(folderEntity.coverArtPath!);
            }
            
            // Add folder to results if not already there (double check)
            if (!existingFolderPaths.contains(folderPath)) {
              folderItems.add(LibraryItem(
                path: folderEntity.path,
                name: folderEntity.name,
                isDirectory: true,
                coverArt: coverArtBytes,
              ));
              existingFolderPaths.add(folderPath);
            }
            continue; // Skip adding individual tracks
          }
        }

        // Otherwise add individual tracks
        for (final track in tracks) {
          processedTrackItems.add(LibraryItem(
            path: track.path,
            name: track.title,
            isDirectory: false,
            durationMs: track.durationMs,
            artist: track.artist,
            album: track.album,
          ));
        }
      }

      _searchResults = [...folderItems, ...processedTrackItems];
    } catch (e) {
      debugPrint('Error searching library: $e');
      _searchResults = [];
    }

    _isSearching = false;
    notifyListeners();
  }

  /// Clear search
  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  /// Get all artists
  Future<List<String>> getAllArtists() async {
    return await _dbService.getAllArtists();
  }

  /// Get all albums
  Future<List<String>> getAllAlbums() async {
    return await _dbService.getAllAlbums();
  }

  /// Get all genres
  Future<List<String>> getAllGenres() async {
    return await _dbService.getAllGenres();
  }

  /// Get tracks by artist
  Future<List<Track>> getTracksByArtist(String artist) async {
    final entities = await _dbService.getTracksByArtist(artist);
    return entities.map((e) => _trackEntityToTrack(e)).toList();
  }

  /// Get tracks by album
  Future<List<Track>> getTracksByAlbum(String album) async {
    final entities = await _dbService.getTracksByAlbum(album);
    return entities.map((e) => _trackEntityToTrack(e)).toList();
  }

  /// Get tracks by genre
  Future<List<Track>> getTracksByGenre(String genre) async {
    final entities = await _dbService.getTracksByGenre(genre);
    return entities.map((e) => _trackEntityToTrack(e)).toList();
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }
}