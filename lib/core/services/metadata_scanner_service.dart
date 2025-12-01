import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path/path.dart' as p;
import '../database/database.dart';
import 'library_database_service.dart';

/// Progress information for library scanning
class ScanProgress {
  final int totalFiles;
  final int scannedFiles;
  final String? currentFile;
  final bool isComplete;
  final String? error;

  const ScanProgress({
    required this.totalFiles,
    required this.scannedFiles,
    this.currentFile,
    this.isComplete = false,
    this.error,
  });

  double get progress => totalFiles > 0 ? scannedFiles / totalFiles : 0;
  
  @override
  String toString() => 'ScanProgress($scannedFiles/$totalFiles, complete: $isComplete)';
}

/// Service for scanning audio files and extracting metadata
class MetadataScannerService {
  static MetadataScannerService? _instance;
  final LibraryDatabaseService _db = LibraryDatabaseService.instance;
  
  /// Number of concurrent file scans
  static const int _concurrentScans = 6;
  
  /// Batch size for processing (should be multiple of _concurrentScans)
  static const int _batchSize = 24;
  
  /// Supported audio file extensions
  static const Set<String> supportedExtensions = {
    '.mp3', '.flac', '.wav', '.aac', '.m4a', '.ogg', '.wma', '.opus', '.aiff',
  };
  
  /// Cover art file names to look for
  static const List<String> coverFileNames = [
    'cover.jpg', 'cover.png', 'cover.webp', 'cover.jpeg',
    'folder.jpg', 'folder.png', 'folder.webp', 'folder.jpeg',
    'album.jpg', 'album.png', 'album.webp', 'album.jpeg',
    'front.jpg', 'front.png', 'front.webp', 'front.jpeg',
  ];

  MetadataScannerService._();

  static MetadataScannerService get instance {
    _instance ??= MetadataScannerService._();
    return _instance!;
  }

  /// Scan multiple library folders
  Stream<ScanProgress> scanLibraryFolders(List<String> folderPaths) async* {
    debugPrint('[MetadataScanner] Starting scan of ${folderPaths.length} folders');
    for (final path in folderPaths) {
      debugPrint('[MetadataScanner] Folder: $path');
    }
    
    int totalFiles = 0;
    int scannedFiles = 0;
    final Set<String> allFolderPaths = {};
    
    // First, count all audio files and collect all folder paths
    for (final path in folderPaths) {
      debugPrint('[MetadataScanner] Counting files in: $path');
      final count = await _countAudioFiles(path);
      debugPrint('[MetadataScanner] Found $count audio files in $path');
      totalFiles += count;
      await _collectAllFolderPaths(path, allFolderPaths);
    }
    
    debugPrint('[MetadataScanner] Total files to scan: $totalFiles');
    
    yield ScanProgress(totalFiles: totalFiles, scannedFiles: 0);
    
    // Scan each folder - use _scanFolderInternal which doesn't reset counters
    for (final path in folderPaths) {
      await for (final progress in _scanFolderInternal(path, totalFiles, scannedFiles)) {
        scannedFiles = progress.scannedFiles;
        yield progress;
      }
    }
    
    // After scanning all files, update folder metadata for all folders
    yield ScanProgress(
      totalFiles: totalFiles,
      scannedFiles: scannedFiles,
      currentFile: 'Updating folder metadata...',
    );
    
    // Create folder entities for all folders (including empty parent folders)
    for (final folderPath in allFolderPaths) {
      await _updateFolderMetadata(folderPath);
    }
    
    // Propagate cover art from subfolders to parent folders
    await _propagateCoverArtToParents(folderPaths, allFolderPaths);
    
    yield ScanProgress(
      totalFiles: totalFiles,
      scannedFiles: scannedFiles,
      isComplete: true,
    );
  }

  /// Collect all folder paths recursively
  Future<void> _collectAllFolderPaths(String path, Set<String> folderPaths) async {
    final directory = Directory(path);
    if (!await directory.exists()) return;
    
    folderPaths.add(path);
    
    try {
      await for (final entity in directory.list()) {
        if (entity is Directory) {
          final name = p.basename(entity.path);
          if (!name.startsWith('.')) {
            await _collectAllFolderPaths(entity.path, folderPaths);
          }
        }
      }
    } catch (e) {
      debugPrint('Error collecting folder paths: $e');
    }
  }

  /// Propagate cover art paths from subfolders to parent folders that don't have their own
  Future<void> _propagateCoverArtToParents(
    List<String> rootPaths,
    Set<String> allFolderPaths,
  ) async {
    // Sort folders by depth (deepest first)
    final sortedFolders = allFolderPaths.toList()
      ..sort((a, b) => b.split(p.separator).length.compareTo(a.split(p.separator).length));
    
    for (final folderPath in sortedFolders) {
      final folder = await _db.getFolderByPath(folderPath);
      if (folder == null) continue;
      
      // If this folder already has cover art, skip
      if (folder.coverArtPath != null) continue;
      
      // Look for cover art path in immediate subfolders
      final coverArtPath = await _findCoverArtPathInSubfolders(folderPath);
      if (coverArtPath != null) {
        folder.coverArtPath = coverArtPath;
        await _db.upsertFolder(folder);
      }
    }
  }

  /// Find cover art path from immediate subfolders
  Future<String?> _findCoverArtPathInSubfolders(String folderPath) async {
    final directory = Directory(folderPath);
    if (!await directory.exists()) return null;
    
    try {
      final subfolders = <Directory>[];
      
      await for (final entity in directory.list()) {
        if (entity is Directory && !p.basename(entity.path).startsWith('.')) {
          subfolders.add(entity);
        }
      }
      
      // Sort subfolders alphabetically for consistent results
      subfolders.sort((a, b) => a.path.compareTo(b.path));
      
      for (final subfolder in subfolders) {
        final subfolderEntity = await _db.getFolderByPath(subfolder.path);
        if (subfolderEntity != null && subfolderEntity.coverArtPath != null) {
          return subfolderEntity.coverArtPath;
        }
      }
    } catch (e) {
      debugPrint('Error finding cover art in subfolders: $e');
    }
    
    return null;
  }

  /// Internal scan method that maintains running count across folders
  Stream<ScanProgress> _scanFolderInternal(String path, int totalFiles, int startingCount) async* {
    final directory = Directory(path);
    if (!await directory.exists()) {
      yield ScanProgress(totalFiles: totalFiles, scannedFiles: startingCount, isComplete: true);
      return;
    }

    final audioFiles = <File>[];
    
    try {
      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          final ext = p.extension(entity.path).toLowerCase();
          if (supportedExtensions.contains(ext)) {
            audioFiles.add(entity);
          }
        }
      }
    } catch (e) {
      debugPrint('Error listing directory $path: $e');
      yield ScanProgress(totalFiles: totalFiles, scannedFiles: startingCount, error: e.toString(), isComplete: true);
      return;
    }

    int scannedFiles = startingCount;
    
    // Process files in batches for efficiency
    final batches = <List<File>>[];
    
    for (int i = 0; i < audioFiles.length; i += _batchSize) {
      final end = (i + _batchSize < audioFiles.length) ? i + _batchSize : audioFiles.length;
      batches.add(audioFiles.sublist(i, end));
    }
    
    for (final batch in batches) {
      final tracks = <TrackEntity>[];
      
      // Process files concurrently in chunks of _concurrentScans
      for (int i = 0; i < batch.length; i += _concurrentScans) {
        final end = (i + _concurrentScans < batch.length) ? i + _concurrentScans : batch.length;
        final chunk = batch.sublist(i, end);
        
        // Scan files concurrently
        final futures = chunk.map((file) async {
          try {
            return await _scanFile(file);
          } catch (e) {
            debugPrint('Error scanning ${file.path}: $e');
            return null;
          }
        });
        
        final results = await Future.wait(futures);
        tracks.addAll(results.whereType<TrackEntity>());
        
        scannedFiles += chunk.length;
        yield ScanProgress(
          totalFiles: totalFiles,
          scannedFiles: scannedFiles,
          currentFile: '${chunk.length} files processed',
        );
      }
      
      // Batch insert tracks
      if (tracks.isNotEmpty) {
        await _db.upsertTracks(tracks);
      }
    }
    
    // Update folder metadata
    await _updateFolderMetadata(path);
    
    yield ScanProgress(totalFiles: totalFiles, scannedFiles: scannedFiles, isComplete: true);
  }

  /// Scan a single folder for audio files (public API - starts fresh count)
  Stream<ScanProgress> scanFolder(String path, {bool recursive = true}) async* {
    final directory = Directory(path);
    if (!await directory.exists()) {
      yield const ScanProgress(totalFiles: 0, scannedFiles: 0, isComplete: true);
      return;
    }

    final audioFiles = <File>[];
    
    try {
      await for (final entity in directory.list(recursive: recursive)) {
        if (entity is File) {
          final ext = p.extension(entity.path).toLowerCase();
          if (supportedExtensions.contains(ext)) {
            audioFiles.add(entity);
          }
        }
      }
    } catch (e) {
      debugPrint('Error listing directory $path: $e');
      yield ScanProgress(totalFiles: 0, scannedFiles: 0, error: e.toString(), isComplete: true);
      return;
    }

    final totalFiles = audioFiles.length;
    int scannedFiles = 0;
    
    // Process files in batches for efficiency
    final batches = <List<File>>[];
    
    for (int i = 0; i < audioFiles.length; i += _batchSize) {
      final end = (i + _batchSize < audioFiles.length) ? i + _batchSize : audioFiles.length;
      batches.add(audioFiles.sublist(i, end));
    }
    
    for (final batch in batches) {
      final tracks = <TrackEntity>[];
      
      // Process files concurrently in chunks of _concurrentScans
      for (int i = 0; i < batch.length; i += _concurrentScans) {
        final end = (i + _concurrentScans < batch.length) ? i + _concurrentScans : batch.length;
        final chunk = batch.sublist(i, end);
        
        // Scan files concurrently
        final futures = chunk.map((file) async {
          try {
            return await _scanFile(file);
          } catch (e) {
            debugPrint('Error scanning ${file.path}: $e');
            return null;
          }
        });
        
        final results = await Future.wait(futures);
        tracks.addAll(results.whereType<TrackEntity>());
        
        scannedFiles += chunk.length;
        yield ScanProgress(
          totalFiles: totalFiles,
          scannedFiles: scannedFiles,
          currentFile: '${chunk.length} files processed',
        );
      }
      
      // Batch insert tracks
      if (tracks.isNotEmpty) {
        await _db.upsertTracks(tracks);
      }
    }
    
    // Update folder metadata
    await _updateFolderMetadata(path);
    
    yield ScanProgress(totalFiles: totalFiles, scannedFiles: scannedFiles, isComplete: true);
  }

  /// Scan a single file and return a TrackEntity
  Future<TrackEntity?> _scanFile(File file) async {
    final stat = await file.stat();
    
    // Check if we need to rescan
    if (!await _db.needsRescan(file.path, stat.modified.millisecondsSinceEpoch)) {
      return null; // Already up to date
    }
    
    // Derive codec from file extension
    final extension = p.extension(file.path).toLowerCase();
    final codec = _extensionToCodec(extension);
    
    final track = TrackEntity()
      ..path = file.path
      ..fileName = p.basename(file.path)
      ..fileNameLower = p.basename(file.path).toLowerCase()
      ..folderPath = p.dirname(file.path)
      ..title = p.basenameWithoutExtension(file.path)  // Default title
      ..artist = 'Unknown Artist'
      ..album = 'Unknown Album'
      ..codec = codec
      ..fileSize = stat.size
      ..lastModifiedMs = stat.modified.millisecondsSinceEpoch
      ..lastScannedMs = DateTime.now().millisecondsSinceEpoch;
    
    try {
      final metadata = await MetadataGod.readMetadata(file: file.path);
      
      // Basic metadata
      if (metadata.title?.isNotEmpty == true) {
        track.title = metadata.title!;
      }
      if (metadata.artist?.isNotEmpty == true) {
        track.artist = metadata.artist!;
      }
      if (metadata.album?.isNotEmpty == true) {
        track.album = metadata.album!;
      }
      
      // Extended metadata
      track.albumArtist = metadata.albumArtist;
      track.year = metadata.year;
      track.genre = metadata.genre;
      track.trackNumber = metadata.trackNumber;
      track.discNumber = metadata.discNumber;
      track.durationMs = metadata.durationMs?.toInt();
      
      // Estimate bitrate from file size and duration
      if (track.durationMs != null && track.durationMs! > 0 && stat.size > 0) {
        // bitrate = (file size in bits) / (duration in seconds)
        // Result is in bits per second
        final durationSeconds = track.durationMs! / 1000.0;
        final fileSizeBits = stat.size * 8;
        track.bitrate = (fileSizeBits / durationSeconds).round();
      }
      
      // Set lowercase fields for indexing
      track.titleLower = track.title.toLowerCase();
      track.artistLower = track.artist.toLowerCase();
      track.albumLower = track.album.toLowerCase();
      track.genreLower = track.genre?.toLowerCase();
      track.albumArtistLower = track.albumArtist?.toLowerCase();
      
      // Handle embedded cover art - just mark that it has embedded art
      if (metadata.picture != null) {
        track.coverArtPath = 'embedded';  // Special marker for embedded art
      }
    } catch (e) {
      debugPrint('Error reading metadata for ${file.path}: $e');
      // Keep the default values set above
      track.titleLower = track.title.toLowerCase();
      track.artistLower = track.artist.toLowerCase();
      track.albumLower = track.album.toLowerCase();
    }
    
    return track;
  }
  
  /// Convert file extension to codec name
  String _extensionToCodec(String extension) {
    switch (extension) {
      case '.mp3':
        return 'MP3';
      case '.flac':
        return 'FLAC';
      case '.wav':
        return 'WAV';
      case '.aac':
        return 'AAC';
      case '.m4a':
        return 'AAC';
      case '.ogg':
        return 'Vorbis';
      case '.opus':
        return 'Opus';
      case '.wma':
        return 'WMA';
      case '.aiff':
        return 'AIFF';
      default:
        return extension.replaceFirst('.', '').toUpperCase();
    }
  }

  /// Scan a single file by path
  Future<TrackEntity?> scanSingleFile(String path) async {
    final file = File(path);
    if (!await file.exists()) return null;
    
    final track = await _scanFile(file);
    if (track != null) {
      await _db.upsertTrack(track);
    }
    return track;
  }

  /// Update folder metadata (cover art path, track count, etc.)
  Future<void> _updateFolderMetadata(String folderPath) async {
    final directory = Directory(folderPath);
    if (!await directory.exists()) return;
    
    // Check if folder already exists in database
    final existingFolder = await _db.getFolderByPath(folderPath);
    final folder = existingFolder ?? FolderEntity();
    
    folder.path = folderPath;
    folder.name = p.basename(folderPath);
    folder.nameLower = p.basename(folderPath).toLowerCase();
    folder.parentPath = p.dirname(folderPath);
    folder.lastScannedMs = DateTime.now().millisecondsSinceEpoch;
    
    // Count tracks in this folder
    final tracks = await _db.getTracksInFolder(folderPath);
    folder.trackCount = tracks.length;
    
    // Count subfolders
    int subfolderCount = 0;
    await for (final entity in directory.list()) {
      if (entity is Directory && !p.basename(entity.path).startsWith('.')) {
        subfolderCount++;
      }
    }
    folder.subfolderCount = subfolderCount;
    
    // Find primary artist/album from tracks
    if (tracks.isNotEmpty) {
      final artistCounts = <String, int>{};
      final albumCounts = <String, int>{};
      
      for (final track in tracks) {
        artistCounts[track.artist] = (artistCounts[track.artist] ?? 0) + 1;
        albumCounts[track.album] = (albumCounts[track.album] ?? 0) + 1;
      }
      
      // Find most common artist/album
      String? topArtist;
      int topArtistCount = 0;
      artistCounts.forEach((artist, count) {
        if (count > topArtistCount && artist != 'Unknown Artist') {
          topArtist = artist;
          topArtistCount = count;
        }
      });
      
      String? topAlbum;
      int topAlbumCount = 0;
      albumCounts.forEach((album, count) {
        if (count > topAlbumCount && album != 'Unknown Album') {
          topAlbum = album;
          topAlbumCount = count;
        }
      });
      
      folder.primaryArtist = topArtist;
      folder.primaryAlbum = topAlbum;
      
      // Get year from first track with a year
      for (final track in tracks) {
        if (track.year != null) {
          folder.primaryYear = track.year;
          break;
        }
      }
    }
    
    // Find folder cover art (only if not already set)
    if (existingFolder == null || folder.coverArtPath == null) {
      final coverArtPath = await _findFolderCoverArtPath(folderPath);
      if (coverArtPath != null) {
        folder.coverArtPath = coverArtPath;
      } else if (tracks.isNotEmpty) {
        // Use first track with embedded art
        for (final track in tracks) {
          if (track.coverArtPath == 'embedded') {
            folder.coverArtPath = track.path;  // Store track path to load embedded art from
            break;
          }
        }
      }
    }
    
    await _db.upsertFolder(folder);
  }

  /// Find cover art file path in a folder
  Future<String?> _findFolderCoverArtPath(String folderPath) async {
    final directory = Directory(folderPath);
    
    try {
      await for (final entity in directory.list()) {
        if (entity is File) {
          final name = p.basename(entity.path).toLowerCase();
          if (coverFileNames.contains(name)) {
            return entity.path;  // Return the path to the cover file
          }
        }
      }
    } catch (e) {
      debugPrint('Error finding folder cover art: $e');
    }
    
    return null;
  }

  /// Count audio files in a folder
  Future<int> _countAudioFiles(String path) async {
    final directory = Directory(path);
    debugPrint('[MetadataScanner] Checking if directory exists: $path');
    
    final exists = await directory.exists();
    debugPrint('[MetadataScanner] Directory exists: $exists');
    
    if (!exists) return 0;
    
    int count = 0;
    try {
      debugPrint('[MetadataScanner] Listing directory recursively: $path');
      await for (final entity in directory.list(recursive: true)) {
        if (entity is File) {
          final ext = p.extension(entity.path).toLowerCase();
          if (supportedExtensions.contains(ext)) {
            count++;
          }
        }
      }
      debugPrint('[MetadataScanner] Counted $count audio files');
    } catch (e, stackTrace) {
      debugPrint('[MetadataScanner] Error counting files in $path: $e');
      debugPrint('[MetadataScanner] Stack trace: $stackTrace');
    }
    
    return count;
  }

  /// Refresh metadata for a specific file
  Future<void> refreshFile(String path) async {
    final file = File(path);
    if (!await file.exists()) return;
    
    // Delete existing track to force rescan
    await _db.deleteTracks([path]);
    
    // Rescan
    await scanSingleFile(path);
  }

  /// Refresh metadata for all files in a folder
  Future<void> refreshFolder(String path) async {
    // Delete existing data
    await _db.deleteTracksInFolder(path);
    await _db.deleteFolder(path);
    
    // Rescan
    await for (final _ in scanFolder(path, recursive: false)) {
      // Just consume the stream
    }
  }

  /// Remove tracks that no longer exist on disk
  Future<int> cleanupMissingTracks() async {
    final allTracks = await _db.getAllTracks();
    final missingPaths = <String>[];
    
    for (final track in allTracks) {
      if (!await File(track.path).exists()) {
        missingPaths.add(track.path);
      }
    }
    
    if (missingPaths.isNotEmpty) {
      await _db.deleteTracks(missingPaths);
    }
    
    return missingPaths.length;
  }
}