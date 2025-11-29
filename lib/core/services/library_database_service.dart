import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../database/database.dart';

/// High-performance database service using Isar for library metadata
class LibraryDatabaseService {
  static LibraryDatabaseService? _instance;
  Isar? _isar;

  LibraryDatabaseService._();

  static LibraryDatabaseService get instance {
    _instance ??= LibraryDatabaseService._();
    return _instance!;
  }

  /// Get the Isar instance, initializing if needed
  Future<Isar> get isar async {
    if (_isar == null || !_isar!.isOpen) {
      await initialize();
    }
    return _isar!;
  }

  /// Initialize the Isar database
  Future<void> initialize() async {
    if (_isar != null && _isar!.isOpen) return;

    final dir = await getApplicationDocumentsDirectory();
    final dbPath = '${dir.path}/foobar_flutter';
    
    // Create directory if it doesn't exist
    await Directory(dbPath).create(recursive: true);

    _isar = await Isar.open(
      [TrackEntitySchema, FolderEntitySchema],
      directory: dbPath,
      name: 'library',
    );

    debugPrint('Isar database initialized at $dbPath');
  }

  /// Close the database
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  // ============ TRACK OPERATIONS ============

  /// Get a track by its file path
  Future<TrackEntity?> getTrackByPath(String path) async {
    final db = await isar;
    return db.trackEntitys.filter().pathEqualTo(path).findFirst();
  }

  /// Get all tracks in the database
  Future<List<TrackEntity>> getAllTracks() async {
    final db = await isar;
    return db.trackEntitys.where().findAll();
  }

  /// Get tracks in a specific folder (non-recursive)
  Future<List<TrackEntity>> getTracksInFolder(String folderPath) async {
    final db = await isar;
    return db.trackEntitys.filter().folderPathEqualTo(folderPath).findAll();
  }

  /// Get tracks in a folder and all subfolders (recursive)
  Future<List<TrackEntity>> getTracksInFolderRecursive(String folderPath) async {
    final db = await isar;
    return db.trackEntitys.filter().folderPathStartsWith(folderPath).findAll();
  }

  /// Insert or update a track
  Future<void> upsertTrack(TrackEntity track) async {
    final db = await isar;
    
    // Check if track already exists
    final existing = await getTrackByPath(track.path);
    if (existing != null) {
      track.id = existing.id;
    }
    
    await db.writeTxn(() async {
      await db.trackEntitys.put(track);
    });
  }

  /// Insert or update multiple tracks efficiently
  Future<void> upsertTracks(List<TrackEntity> tracks) async {
    if (tracks.isEmpty) return;
    
    final db = await isar;
    
    await db.writeTxn(() async {
      // Get existing tracks by path
      for (final track in tracks) {
        final existing = await db.trackEntitys.filter().pathEqualTo(track.path).findFirst();
        if (existing != null) {
          track.id = existing.id;
        }
      }
      
      await db.trackEntitys.putAll(tracks);
    });
  }

  /// Delete tracks by their paths
  Future<void> deleteTracks(List<String> paths) async {
    if (paths.isEmpty) return;
    
    final db = await isar;
    await db.writeTxn(() async {
      for (final path in paths) {
        await db.trackEntitys.filter().pathEqualTo(path).deleteAll();
      }
    });
  }

  /// Delete all tracks in a folder
  Future<void> deleteTracksInFolder(String folderPath) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.trackEntitys.filter().folderPathEqualTo(folderPath).deleteAll();
    });
  }

  // ============ FOLDER OPERATIONS ============

  /// Get a folder by its path
  Future<FolderEntity?> getFolderByPath(String path) async {
    final db = await isar;
    return db.folderEntitys.filter().pathEqualTo(path).findFirst();
  }

  /// Insert or update a folder
  Future<void> upsertFolder(FolderEntity folder) async {
    final db = await isar;
    
    final existing = await getFolderByPath(folder.path);
    if (existing != null) {
      folder.id = existing.id;
    }
    
    await db.writeTxn(() async {
      await db.folderEntitys.put(folder);
    });
  }

  /// Delete a folder
  Future<void> deleteFolder(String path) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.folderEntitys.filter().pathEqualTo(path).deleteAll();
    });
  }

  // ============ QUERY OPERATIONS ============

  /// Search tracks by title, artist, album, or filename, optionally scoped to a path
  Future<List<TrackEntity>> searchTracks(String query, {String? searchPath}) async {
    final db = await isar;
    final lowerQuery = query.toLowerCase();
    
    var filter = db.trackEntitys.filter();
    
    if (searchPath != null) {
      // Scope to searchPath
      return filter
          .folderPathStartsWith(searchPath)
          .and()
          .group((q) => q
            .titleLowerContains(lowerQuery)
            .or()
            .artistLowerContains(lowerQuery)
            .or()
            .albumLowerContains(lowerQuery)
            .or()
            .fileNameLowerContains(lowerQuery)
          )
          .findAll();
    } else {
      return filter
          .titleLowerContains(lowerQuery)
          .or()
          .artistLowerContains(lowerQuery)
          .or()
          .albumLowerContains(lowerQuery)
          .or()
          .fileNameLowerContains(lowerQuery)
          .findAll();
    }
  }

  /// Search folders by name, optionally scoped to a path
  Future<List<FolderEntity>> searchFolders(String query, {String? searchPath}) async {
    final db = await isar;
    final lowerQuery = query.toLowerCase();
    
    var filter = db.folderEntitys.filter();
    
    if (searchPath != null) {
      return filter
          .pathStartsWith(searchPath)
          .and()
          .nameLowerContains(lowerQuery)
          .findAll();
    } else {
      return filter
          .nameLowerContains(lowerQuery)
          .findAll();
    }
  }

  /// Get all unique artists
  Future<List<String>> getAllArtists() async {
    final db = await isar;
    final tracks = await db.trackEntitys.where().findAll();
    
    final artists = <String>{};
    for (final track in tracks) {
      if (track.artist.isNotEmpty && track.artist != 'Unknown Artist') {
        artists.add(track.artist);
      }
    }
    
    final sorted = artists.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return sorted;
  }

  /// Get all unique albums
  Future<List<String>> getAllAlbums() async {
    final db = await isar;
    final tracks = await db.trackEntitys.where().findAll();
    
    final albums = <String>{};
    for (final track in tracks) {
      if (track.album.isNotEmpty && track.album != 'Unknown Album') {
        albums.add(track.album);
      }
    }
    
    final sorted = albums.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return sorted;
  }

  /// Get all unique genres
  Future<List<String>> getAllGenres() async {
    final db = await isar;
    final tracks = await db.trackEntitys.where().findAll();
    
    final genres = <String>{};
    for (final track in tracks) {
      if (track.genre != null && track.genre!.isNotEmpty) {
        genres.add(track.genre!);
      }
    }
    
    final sorted = genres.toList()..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return sorted;
  }

  /// Get tracks by artist
  Future<List<TrackEntity>> getTracksByArtist(String artist) async {
    final db = await isar;
    return db.trackEntitys.filter().artistLowerEqualTo(artist.toLowerCase()).findAll();
  }

  /// Get tracks by album
  Future<List<TrackEntity>> getTracksByAlbum(String album) async {
    final db = await isar;
    return db.trackEntitys.filter().albumLowerEqualTo(album.toLowerCase()).findAll();
  }

  /// Get tracks by genre
  Future<List<TrackEntity>> getTracksByGenre(String genre) async {
    final db = await isar;
    return db.trackEntitys.filter().genreLowerEqualTo(genre.toLowerCase()).findAll();
  }

  /// Get tracks by year
  Future<List<TrackEntity>> getTracksByYear(int year) async {
    final db = await isar;
    return db.trackEntitys.filter().yearEqualTo(year).findAll();
  }

  // ============ UTILITY OPERATIONS ============

  /// Check if a track needs to be rescanned based on file modification time
  Future<bool> needsRescan(String path, int lastModifiedMs) async {
    final track = await getTrackByPath(path);
    if (track == null) return true;
    
    return track.lastModifiedMs != lastModifiedMs;
  }

  /// Get database statistics
  Future<Map<String, int>> getStats() async {
    final db = await isar;
    
    final artists = await getAllArtists();
    final albums = await getAllAlbums();
    
    return {
      'tracks': await db.trackEntitys.count(),
      'folders': await db.folderEntitys.count(),
      'artists': artists.length,
      'albums': albums.length,
    };
  }

  /// Clear the entire database
  Future<void> clearDatabase() async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.trackEntitys.clear();
      await db.folderEntitys.clear();
    });
  }
}