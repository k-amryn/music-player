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
              Icons.music_note,
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

          // Playback controls
          _buildPlaybackControls(context, audio, theme),
        ],
      ),
    );
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
      Icons.album,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        IconButton(
          onPressed: audio.hasPrevious || audio.position.inSeconds > 3
              ? () => audio.previous()
              : null,
          icon: const Icon(Icons.skip_previous),
          iconSize: 32,
          color: theme.colorScheme.onSurface,
        ),

        const SizedBox(width: AppDimensions.spacingMd),

        // Play/Pause button
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => audio.playPause(),
            icon: Icon(
              audio.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            iconSize: 36,
            color: theme.colorScheme.onPrimary,
          ),
        ),

        const SizedBox(width: AppDimensions.spacingMd),

        // Next button
        IconButton(
          onPressed: audio.hasNext ? () => audio.next() : null,
          icon: const Icon(Icons.skip_next),
          iconSize: 32,
          color: theme.colorScheme.onSurface,
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