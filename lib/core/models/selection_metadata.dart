import 'package:flutter/foundation.dart';

@immutable
class SelectionMetadata {
  final Duration totalDuration;
  final String? album;
  final String? artist;
  final String? albumArtist;
  final String? genre;
  final String? year;
  final String? codec;
  final int? avgBitrate;
  final int? totalSize;
  final int count;

  const SelectionMetadata({
    required this.totalDuration,
    required this.album,
    required this.artist,
    required this.albumArtist,
    required this.genre,
    required this.year,
    required this.codec,
    required this.avgBitrate,
    required this.totalSize,
    required this.count,
  });
}