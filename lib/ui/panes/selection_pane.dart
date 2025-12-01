import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/library_provider.dart';
import '../../core/models/selection_metadata.dart';
import '../../theme/app_theme.dart';

class SelectionPane extends StatelessWidget {
  const SelectionPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryProvider>(
      builder: (context, library, child) {
        return FutureBuilder<SelectionMetadata>(
          future: library.getSelectionMetadata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final metadata = snapshot.data;
            if (metadata == null || metadata.count == 0) {
              return const Center(child: Text('No items selected'));
            }

            return _buildContent(context, metadata);
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, SelectionMetadata metadata) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selection Details',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            _buildRow(theme, 'Items', '${metadata.count} tracks'),
            _buildRow(theme, 'Total Duration', _formatDuration(metadata.totalDuration)),
            const Divider(height: AppDimensions.spacingMd * 2),
            if (metadata.artist != null)
              _buildRow(theme, 'Artist', metadata.artist!),
            if (metadata.albumArtist != null)
              _buildRow(theme, 'Album Artist', metadata.albumArtist!),
            if (metadata.album != null)
              _buildRow(theme, 'Album', metadata.album!),
            if (metadata.genre != null)
              _buildRow(theme, 'Genre', metadata.genre!),
            if (metadata.year != null)
              _buildRow(theme, 'Year', metadata.year!),
            const Divider(height: AppDimensions.spacingMd * 2),
            if (metadata.codec != null)
              _buildRow(theme, 'Codec', metadata.codec!),
            if (metadata.avgBitrate != null)
              _buildRow(theme, 'Avg Bitrate', '${(metadata.avgBitrate! / 1000).round()} kbps'),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}