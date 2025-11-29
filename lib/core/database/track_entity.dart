import 'package:isar/isar.dart';

part 'track_entity.g.dart';

/// Isar collection for storing audio track metadata
@collection
class TrackEntity {
  Id id = Isar.autoIncrement;

  /// File path (unique identifier)
  @Index(unique: true)
  late String path;

  /// File name for display
  late String fileName;

  /// Parent folder path
  @Index()
  late String folderPath;

  // Basic metadata
  late String title;
  late String artist;
  late String album;
  String? albumArtist;

  // Track info
  int? trackNumber;
  int? totalTracks;
  int? discNumber;
  int? totalDiscs;
  int? year;
  String? genre;

  // Extended metadata
  String? composer;
  String? conductor;
  String? comment;
  String? lyrics;

  // Technical info
  int? durationMs;
  int? bitrate;
  int? sampleRate;
  int? channels;
  String? codec;

  // File info
  int? fileSize;
  int? lastModifiedMs;
  int? lastScannedMs;

  // Lowercase indexes for case-insensitive search
  @Index()
  late String artistLower;
  @Index()
  late String albumLower;
  @Index()
  late String titleLower;
  @Index()
  String? genreLower;
  @Index()
  String? albumArtistLower;
  @Index()
  late String fileNameLower;

  /// Cover art source path - can be:
  /// - A cover image file path (cover.jpg, etc.)
  /// - "embedded" to indicate embedded art (load from track file)
  String? coverArtPath;

  /// Create a TrackEntity with default values
  TrackEntity();

  /// Helper to format duration as MM:SS or HH:MM:SS
  @ignore
  String get formattedDuration {
    if (durationMs == null) return '';
    final dur = Duration(milliseconds: durationMs!);
    final hours = dur.inHours;
    final minutes = dur.inMinutes.remainder(60);
    final seconds = dur.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get Duration object
  @ignore
  Duration? get duration => durationMs != null ? Duration(milliseconds: durationMs!) : null;
}