import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/track.dart';
import '../../core/providers/audio_provider.dart';
import '../../core/providers/library_provider.dart';
import '../../theme/app_theme.dart';

/// Queue pane showing the current playback queue
class QueuePane extends StatefulWidget {
  const QueuePane({super.key});

  @override
  State<QueuePane> createState() => _QueuePaneState();
}

class _QueuePaneState extends State<QueuePane> {
  /// Index where a drop would occur (-1 = no drop target active)
  int _dropIndex = -1;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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

    // Build the queue content (empty state or list)
    Widget queueContent;
    
    if (queue.isEmpty) {
      queueContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music_rounded,
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
              'Drag tracks here from the Library',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    } else {
      queueContent = Column(
        children: [
          // Queue header
          _buildHeader(context, audio, theme),
          
          // Queue list
          Expanded(
            child: ReorderableListView.builder(
              scrollController: _scrollController,
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
                    key: ValueKey('queue_${track.id}_$index'),
                    track: track,
                    index: index,
                    isPlaying: isPlaying,
                    audio: audio,
                    theme: theme,
                    dropIndex: _dropIndex,
                  );
              },
            ),
          ),
          // Show drop indicator at end of list if dropping at end
          if (_dropIndex == queue.length)
            Container(
              height: 2,
              color: theme.colorScheme.primary,
            ),
        ],
      );
    }

    // Wrap in DragTarget to accept library items
    return DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        final data = details.data;
        return data['type'] == 'library_items';
      },
      onMove: (details) {
        // Calculate drop index based on Y position
        final renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(details.offset);
        
        // If in header (top 48px), index 0. Else index length (end of list).
        // Items handle their own drop targets.
        if (localPosition.dy < 48) {
           if (_dropIndex != 0) setState(() => _dropIndex = 0);
        } else {
           if (_dropIndex != queue.length) setState(() => _dropIndex = queue.length);
        }
      },
      onLeave: (_) {
        setState(() => _dropIndex = -1);
      },
      onAcceptWithDetails: (details) async {
        final data = details.data;
        final paths = data['paths'] as List<String>? ?? [];
        
        if (paths.isNotEmpty) {
          final library = context.read<LibraryProvider>();
          final audio = context.read<AudioProvider>();
          final tracks = <Track>[];
          
          for (final path in paths) {
            if (await library.pathExists(path)) {
              final isDir = await _isDirectory(path);
              if (isDir) {
                // Get all tracks in directory
                tracks.addAll(await library.getAllTracksInDirectory(path));
              } else {
                // Single track - just create from path
                tracks.add(Track.fromPath(path));
              }
            }
          }
          
          if (tracks.isNotEmpty) {
            // If _dropIndex is -1 (e.g. dropped on empty space but onMove didn't fire?), default to end
            final insertIndex = _dropIndex >= 0 ? _dropIndex : queue.length;
            audio.insertTracksAt(tracks, insertIndex);
          }
        }
        
        setState(() => _dropIndex = -1);
      },
      builder: (context, candidateData, rejectedData) {
        return queueContent;
      },
    );
  }

  Future<bool> _isDirectory(String path) async {
    try {
      return await Directory(path).exists();
    } catch (e) {
      return false;
    }
  }

  Widget _buildHeader(BuildContext context, AudioProvider audio, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingSm,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: theme.scaffoldBackgroundColor,
            width: 1,
          ),
        ),
      ),
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
            icon: const Icon(Icons.clear_all_rounded, size: 18),
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
    required int dropIndex,
  }) {
    final showDropIndicator = dropIndex == index;
    
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drop indicator line
        if (showDropIndicator)
          Container(
            height: 2,
            color: theme.colorScheme.primary,
          ),
        DragTarget<Map<String, dynamic>>(
          onWillAcceptWithDetails: (details) {
            final data = details.data;
            return data['type'] == 'library_items';
          },
          onMove: (details) {
            if (_dropIndex != index) {
              setState(() => _dropIndex = index);
            }
          },
          onLeave: (_) {
            if (_dropIndex == index) {
              setState(() => _dropIndex = -1);
            }
          },
          onAcceptWithDetails: (details) async {
            final data = details.data;
            final paths = data['paths'] as List<String>? ?? [];
            
            if (paths.isNotEmpty) {
              final library = context.read<LibraryProvider>();
              final audio = context.read<AudioProvider>();
              final tracks = <Track>[];
              
              for (final path in paths) {
                if (await library.pathExists(path)) {
                  final isDir = await _isDirectory(path);
                  if (isDir) {
                    tracks.addAll(await library.getAllTracksInDirectory(path));
                  } else {
                    tracks.add(Track.fromPath(path));
                  }
                }
              }
              
              if (tracks.isNotEmpty) {
                audio.insertTracksAt(tracks, index);
              }
            }
            
            setState(() => _dropIndex = -1);
          },
          builder: (context, candidateData, rejectedData) {
            return Material(
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
                                Icons.play_arrow_rounded,
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
                        icon: const Icon(Icons.close_rounded),
                        iconSize: 18,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      
                      // Drag handle
                      ReorderableDragStartListener(
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.drag_handle_rounded,
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
          },
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}