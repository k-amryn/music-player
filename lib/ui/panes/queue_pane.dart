import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/track.dart';
import '../../core/providers/audio_provider.dart';
import '../../theme/app_theme.dart';

/// Queue pane showing the current playback queue
class QueuePane extends StatelessWidget {
  const QueuePane({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, child) {
        return _buildContent(context, audio);
      },
    );
  }

  Widget _buildContent(BuildContext context, AudioProvider audio) {
    final theme = Theme.of(context);
    final queue = audio.queue;
    final currentIndex = audio.currentIndex;

    if (queue.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              'Queue is empty',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Add tracks from the Library',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Queue header
        _buildHeader(context, audio, theme),
        
        // Queue list
        Expanded(
          child: ReorderableListView.builder(
            itemCount: queue.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              audio.reorderQueue(oldIndex, newIndex);
            },
            buildDefaultDragHandles: false,
            itemBuilder: (context, index) {
              final track = queue[index];
              final isPlaying = index == currentIndex;
              
              return _buildQueueItem(
                context: context,
                key: ValueKey(track.id),
                track: track,
                index: index,
                isPlaying: isPlaying,
                audio: audio,
                theme: theme,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, AudioProvider audio, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final headerColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingSm,
      ),
      color: headerColor,
      child: Row(
        children: [
          Text(
            '${audio.queue.length} tracks',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () => audio.clearQueue(),
            icon: const Icon(Icons.clear_all, size: 18),
            label: const Text('Clear'),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem({
    required BuildContext context,
    required Key key,
    required Track track,
    required int index,
    required bool isPlaying,
    required AudioProvider audio,
    required ThemeData theme,
  }) {
    return Material(
      key: key,
      color: isPlaying
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
          : Colors.transparent,
      child: InkWell(
        onTap: () => audio.skipToTrack(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingSm,
            vertical: AppDimensions.spacingXs,
          ),
          child: Row(
            children: [
              // Track number or playing indicator
              SizedBox(
                width: 32,
                child: isPlaying
                    ? Icon(
                        Icons.play_arrow,
                        color: theme.colorScheme.primary,
                        size: 20,
                      )
                    : Text(
                        '${index + 1}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              
              // Track info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      track.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isPlaying
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                        fontWeight: isPlaying ? FontWeight.w500 : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artist,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Duration
              Text(
                _formatDuration(track.duration),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              
              // Remove button
              IconButton(
                onPressed: () => audio.removeFromQueue(index),
                icon: const Icon(Icons.close),
                iconSize: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              
              // Drag handle
              ReorderableDragStartListener(
                index: index,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.drag_handle,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}