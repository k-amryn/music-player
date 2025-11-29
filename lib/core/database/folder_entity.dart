import 'package:isar/isar.dart';

part 'folder_entity.g.dart';

/// Isar collection for caching folder information
@collection
class FolderEntity {
  Id id = Isar.autoIncrement;

  /// Folder path (unique identifier)
  @Index(unique: true)
  late String path;

  /// Folder name for display
  late String name;

  /// Lowercase name for searching
  @Index()
  late String nameLower;

  /// Parent folder path (null for root library folders)
  String? parentPath;

  /// Number of audio tracks in this folder
  int? trackCount;

  /// Number of subfolders
  int? subfolderCount;

  /// When this folder was last scanned
  int? lastScannedMs;

  /// Aggregated metadata from contained tracks
  /// Most common artist in this folder
  String? primaryArtist;

  /// Album name if this folder represents an album
  String? primaryAlbum;

  /// Primary year from tracks
  int? primaryYear;

  /// Path to the cover art source - can be:
  /// - An image file path (cover.jpg, folder.jpg, etc.)
  /// - A track path (for loading embedded art on-demand)
  /// - "embedded:{trackPath}" for embedded art
  String? coverArtPath;

  FolderEntity();
}