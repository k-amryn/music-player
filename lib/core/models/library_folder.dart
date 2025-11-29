import 'package:flutter/foundation.dart';

/// Represents a folder in the user's music library
@immutable
class LibraryFolder {
  final String id;
  final String path;
  final String name;
  final bool isDefault;

  const LibraryFolder({
    required this.id,
    required this.path,
    required this.name,
    this.isDefault = false,
  });

  factory LibraryFolder.fromPath(String path, {bool isDefault = false}) {
    final name = path.split('/').last.split('\\').last;
    return LibraryFolder(
      id: path.hashCode.toString(),
      path: path,
      name: name.isEmpty ? path : name,
      isDefault: isDefault,
    );
  }

  LibraryFolder copyWith({
    String? id,
    String? path,
    String? name,
    bool? isDefault,
  }) {
    return LibraryFolder(
      id: id ?? this.id,
      path: path ?? this.path,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'name': name,
      'isDefault': isDefault,
    };
  }

  factory LibraryFolder.fromJson(Map<String, dynamic> json) {
    return LibraryFolder(
      id: json['id'] as String,
      path: json['path'] as String,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LibraryFolder && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'LibraryFolder(name: $name, path: $path)';
}

/// Represents an item in a library folder (either a folder or a track)
@immutable
class LibraryItem {
  final String path;
  final String name;
  final bool isDirectory;
  final DateTime? modifiedDate;
  final dynamic coverArt; // String (path) or Uint8List (bytes)
  final int? durationMs; // Track duration in milliseconds
  final String? artist;
  final String? album;

  const LibraryItem({
    required this.path,
    required this.name,
    required this.isDirectory,
    this.modifiedDate,
    this.coverArt,
    this.durationMs,
    this.artist,
    this.album,
  });

  /// Format duration as MM:SS or HH:MM:SS
  String get formattedDuration {
    if (durationMs == null) return '';
    final duration = Duration(milliseconds: durationMs!);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LibraryItem && other.path == path;
  }

  @override
  int get hashCode => path.hashCode;
}