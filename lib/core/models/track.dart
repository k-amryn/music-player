import 'package:flutter/foundation.dart';

/// Represents a music track with its metadata
@immutable
class Track {
  final String id;
  final String path;
  final String title;
  final String artist;
  final String album;
  final String? albumArtist;
  final Duration duration;
  final String? albumArtPath;
  final Uint8List? albumArtBytes;
  final int? trackNumber;
  final int? discNumber;
  final String? genre;
  final int? year;
  final int? bitrate;
  final String? codec;
  final int? fileSize;

  const Track({
    required this.id,
    required this.path,
    required this.title,
    this.artist = 'Unknown Artist',
    this.album = 'Unknown Album',
    this.albumArtist,
    this.duration = Duration.zero,
    this.albumArtPath,
    this.albumArtBytes,
    this.trackNumber,
    this.discNumber,
    this.genre,
    this.year,
    this.bitrate,
    this.codec,
    this.fileSize,
  });

  /// Creates a Track from a file path with basic metadata
  factory Track.fromPath(String path) {
    final fileName = path.split('/').last.split('\\').last;
    final nameWithoutExtension = fileName.replaceAll(RegExp(r'\.[^.]+$'), '');
    
    return Track(
      id: path.hashCode.toString(),
      path: path,
      title: nameWithoutExtension,
    );
  }

  Track copyWith({
    String? id,
    String? path,
    String? title,
    String? artist,
    String? album,
    String? albumArtist,
    Duration? duration,
    String? albumArtPath,
    Uint8List? albumArtBytes,
    int? trackNumber,
    int? discNumber,
    String? genre,
    int? year,
    int? bitrate,
    String? codec,
    int? fileSize,
  }) {
    return Track(
      id: id ?? this.id,
      path: path ?? this.path,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArtist: albumArtist ?? this.albumArtist,
      duration: duration ?? this.duration,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      albumArtBytes: albumArtBytes ?? this.albumArtBytes,
      trackNumber: trackNumber ?? this.trackNumber,
      discNumber: discNumber ?? this.discNumber,
      genre: genre ?? this.genre,
      year: year ?? this.year,
      bitrate: bitrate ?? this.bitrate,
      codec: codec ?? this.codec,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'title': title,
      'artist': artist,
      'album': album,
      'albumArtist': albumArtist,
      'duration': duration.inMilliseconds,
      'albumArtPath': albumArtPath,
      // Note: albumArtBytes is not serialized to JSON to avoid large payloads
      'trackNumber': trackNumber,
      'discNumber': discNumber,
      'genre': genre,
      'year': year,
      'bitrate': bitrate,
      'codec': codec,
      'fileSize': fileSize,
    };
  }

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] as String,
      path: json['path'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String? ?? 'Unknown Artist',
      album: json['album'] as String? ?? 'Unknown Album',
      albumArtist: json['albumArtist'] as String?,
      duration: Duration(milliseconds: json['duration'] as int? ?? 0),
      albumArtPath: json['albumArtPath'] as String?,
      trackNumber: json['trackNumber'] as int?,
      discNumber: json['discNumber'] as int?,
      genre: json['genre'] as String?,
      year: json['year'] as int?,
      bitrate: json['bitrate'] as int?,
      codec: json['codec'] as String?,
      fileSize: json['fileSize'] as int?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Track && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Track(title: $title, artist: $artist, album: $album)';
}