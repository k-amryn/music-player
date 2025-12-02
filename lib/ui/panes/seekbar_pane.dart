import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/audio_provider.dart';
import '../../theme/app_theme.dart';

class SeekbarPane extends StatelessWidget {
  const SeekbarPane({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audio = context.watch<AudioProvider>();
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: audio.position.inMilliseconds.toDouble().clamp(0, audio.duration.inMilliseconds.toDouble()),
              max: audio.duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                audio.seek(Duration(milliseconds: value.toInt()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingSm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(audio.position),
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    _formatDuration(audio.duration),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
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