import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/audio_provider.dart';
import '../../theme/app_theme.dart';

class ControlsPane extends StatelessWidget {
  const ControlsPane({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audio = context.watch<AudioProvider>();

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Speed
          IconButton(
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
          ),
          const SizedBox(width: 8),
          
          // Skip Back
          IconButton(
            onPressed: audio.hasPrevious ? audio.previous : null,
            icon: const Icon(Icons.skip_previous_rounded),
            tooltip: 'Previous',
          ),
          
          // Rewind 5s
          IconButton(
            onPressed: () => audio.seekBy(const Duration(seconds: -5)),
            icon: const Icon(Icons.replay_5_rounded),
            tooltip: 'Rewind 5s',
          ),
          
          // Play/Pause
          IconButton(
            onPressed: audio.playPause,
            icon: Icon(
              audio.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            iconSize: 48,
            tooltip: audio.isPlaying ? 'Pause' : 'Play',
          ),
          
          // Forward 5s
          IconButton(
            onPressed: () => audio.seekBy(const Duration(seconds: 5)),
            icon: const Icon(Icons.forward_5_rounded),
            tooltip: 'Forward 5s',
          ),
          
          // Skip Forward
          IconButton(
            onPressed: audio.hasNext ? audio.next : null,
            icon: const Icon(Icons.skip_next_rounded),
            tooltip: 'Next',
          ),
        ],
      ),
    );
  }
}