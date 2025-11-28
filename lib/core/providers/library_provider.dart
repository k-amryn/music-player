import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import '../models/library_folder.dart';
import '../models/track.dart';

/// Provider for browsing the music library
class LibraryProvider extends ChangeNotifier {
  // Supported audio file extensions
  static const Set<String> supportedExtensions = {
    '.mp3', '.flac', '.wav', '.aac', '.m4a', '.ogg', '.wma', '.opus', '.aiff',
  };

  /// Get items in a directory
  Future<List<LibraryItem>> getDirectoryContents(String path) async {
    try {
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
          items.add(LibraryItem(
            path: entity.path,
            name: name,
            isDirectory: true,
          ));
        } else if (entity is File) {
          final extension = p.extension(entity.path).toLowerCase();
          if (supportedExtensions.contains(extension)) {
            final stat = await entity.stat();
            items.add(LibraryItem(
              path: entity.path,
              name: name,
              isDirectory: false,
              modifiedDate: stat.modified,
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

  /// Get all tracks in a directory (including subdirectories)
  Future<List<Track>> getAllTracksInDirectory(String path) async {
    final tracks = <Track>[];
    
    try {
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

      // Sort by path
      tracks.sort((a, b) => a.path.compareTo(b.path));
    } catch (e) {
      debugPrint('Error getting tracks: $e');
    }

    return tracks;
  }

  /// Get tracks from a list of files in a directory (non-recursive)
  Future<List<Track>> getTracksInDirectory(String path) async {
    final items = await getDirectoryContents(path);
    return items
        .where((item) => !item.isDirectory)
        .map((item) => Track.fromPath(item.path))
        .toList();
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
}