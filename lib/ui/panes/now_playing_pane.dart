import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/audio_provider.dart';
import '../../theme/app_theme.dart';

/// Now Playing pane showing current track info and playback controls
class NowPlayingPane extends StatelessWidget {
  final Map<String, dynamic> settings;

  const NowPlayingPane({
    super.key,
    this.settings = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audio, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxHeight < 300;
            return _buildContent(context, audio, isCompact);
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, AudioProvider audio, bool isCompact) {
    final theme = Theme.of(context);
    final track = audio.currentTrack;

    if (track == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note_rounded,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              'No track playing',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        children: [
          // Album art area (expanded)
          if (!isCompact)
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                      child: _buildAlbumArt(context, track, theme),
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(height: AppDimensions.spacingMd),

          // Track info
          _buildTrackInfo(context, track, theme),

          const SizedBox(height: AppDimensions.spacingMd),

          // Seek bar
          _buildSeekBar(context, audio, theme),

          const SizedBox(height: AppDimensions.spacingSm),

          // Playback controls area with speed toggle
          SizedBox(
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildPlaybackControls(context, audio, theme),
                Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: _buildSpeedControl(context, audio, theme),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: _buildVolumeControl(context, audio, theme),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedControl(BuildContext context, AudioProvider audio, ThemeData theme) {
    return IconButton(
      onPressed: () {
        // Cycle speeds: 0.5, 1.0, 1.5, 2.0
        final newSpeed = audio.speed >= 2.0 ? 0.5 : audio.speed + 0.5;
        audio.setSpeed(newSpeed);
      },
      icon: Text(
        '${audio.speed}x',
        style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      tooltip: 'Playback Speed',
    );
  }

  Widget _buildVolumeControl(BuildContext context, AudioProvider audio, ThemeData theme) {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(_getVolumeIcon(audio.volume)),
          tooltip: 'Volume',
          onPressed: () {
            final renderBox = context.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero);
            
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy - 160,
                offset.dx + renderBox.size.width,
                offset.dy,
              ),
              constraints: const BoxConstraints(
                minWidth: 40,
                maxWidth: 40,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              items: [
                PopupMenuItem(
                  enabled: false,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 30,
                      child: Consumer<AudioProvider>(
                        builder: (context, audio, _) {
                          return RotatedBox(
                            quarterTurns: 3,
                            child: SliderTheme(
                              data: theme.sliderTheme.copyWith(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                              ),
                              child: Slider(
                                value: audio.volume,
                                onChanged: (value) => audio.setVolume(value),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    );
  }

  IconData _getVolumeIcon(double volume) {
    if (volume <= 0) return Icons.volume_off_rounded;
    if (volume < 0.5) return Icons.volume_down_rounded;
    return Icons.volume_up_rounded;
  }

  Widget _buildAlbumArt(BuildContext context, dynamic track, ThemeData theme) {
    if (track.albumArtBytes != null) {
      return Image.memory(
        track.albumArtBytes!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(theme);
        },
      );
    } else if (track.albumArtPath != null) {
      return Image.file(
        File(track.albumArtPath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(theme);
        },
      );
    } else {
      return _buildPlaceholder(theme);
    }
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Icon(
      Icons.album_rounded,
      size: 100,
      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
    );
  }

  Widget _buildTrackInfo(BuildContext context, dynamic track, ThemeData theme) {
    return Column(
      children: [
        Text(
          track.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppDimensions.spacingXs),
        Text(
          track.artist,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppDimensions.spacingXxs),
        Text(
          track.album,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSeekBar(BuildContext context, AudioProvider audio, ThemeData theme) {
    final position = audio.position;
    final duration = audio.duration;
    final progress = duration.inMilliseconds > 0
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    return Column(
      children: [
        SliderTheme(
          data: theme.sliderTheme.copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: Slider(
            value: progress.clamp(0.0, 1.0),
            onChanged: (value) {
              final newPosition = Duration(
                milliseconds: (value * duration.inMilliseconds).round(),
              );
              audio.seek(newPosition);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(position),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                _formatDuration(duration),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaybackControls(
    BuildContext context,
    AudioProvider audio,
    ThemeData theme,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Shrink gap if pane is narrow
        final isNarrow = constraints.maxWidth < 300;
        final gap = isNarrow ? 2.0 : AppDimensions.spacingSm;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous button
            IconButton(
              onPressed: audio.hasPrevious || audio.position.inSeconds > 3
                  ? () => audio.previous()
                  : null,
              icon: const Icon(Icons.skip_previous_rounded),
              iconSize: 24,
              padding: isNarrow ? const EdgeInsets.all(4) : null,
              constraints: isNarrow ? const BoxConstraints() : null,
              color: theme.colorScheme.onSurface,
            ),

            SizedBox(width: gap),

            // Rewind 5s
            IconButton(
              onPressed: () => audio.seekBy(const Duration(seconds: -5)),
              icon: const Icon(Icons.replay_5_rounded),
              iconSize: 24,
              tooltip: 'Rewind 5s',
              padding: isNarrow ? const EdgeInsets.all(4) : null,
              constraints: isNarrow ? const BoxConstraints() : null,
              color: theme.colorScheme.onSurface,
            ),

            SizedBox(width: gap),

            // Play/Pause button
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => audio.playPause(),
                icon: Icon(
                  audio.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                ),
                iconSize: 32,
                padding: isNarrow ? const EdgeInsets.all(4) : null,
                constraints: isNarrow ? const BoxConstraints() : null,
                color: theme.colorScheme.onPrimary,
              ),
            ),

            SizedBox(width: gap),

            // Forward 5s
            IconButton(
              onPressed: () => audio.seekBy(const Duration(seconds: 5)),
              icon: const Icon(Icons.forward_5_rounded),
              iconSize: 24,
              tooltip: 'Forward 5s',
              padding: isNarrow ? const EdgeInsets.all(4) : null,
              constraints: isNarrow ? const BoxConstraints() : null,
              color: theme.colorScheme.onSurface,
            ),

            SizedBox(width: gap),

            // Next button
            IconButton(
              onPressed: audio.hasNext ? () => audio.next() : null,
              icon: const Icon(Icons.skip_next_rounded),
              iconSize: 24,
              padding: isNarrow ? const EdgeInsets.all(4) : null,
              constraints: isNarrow ? const BoxConstraints() : null,
              color: theme.colorScheme.onSurface,
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}