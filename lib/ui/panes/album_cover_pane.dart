import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/audio_provider.dart';
import '../../theme/app_theme.dart';

class AlbumCoverPane extends StatelessWidget {
  const AlbumCoverPane({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audio = context.watch<AudioProvider>();
    final track = audio.currentTrack;

    if (track == null) {
      return Center(
        child: Icon(
          Icons.album_rounded,
          size: 64,
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: _buildCoverImage(track.albumArtBytes, track.albumArtPath, theme),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverImage(Uint8List? bytes, String? path, ThemeData theme) {
    if (bytes != null && bytes.isNotEmpty) {
      return Image.memory(bytes, fit: BoxFit.cover);
    } else if (path != null && path.isNotEmpty) {
      return Image.file(File(path), fit: BoxFit.cover);
    } else {
      return Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.music_note_rounded,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
  }
}