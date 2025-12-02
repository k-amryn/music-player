import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/audio_provider.dart';
import '../../theme/app_theme.dart';

class VolumePane extends StatelessWidget {
  const VolumePane({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Consumer<AudioProvider>(
      builder: (context, audio, child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (audio.volume > 0) {
                      audio.setVolume(0);
                    } else {
                      audio.setVolume(1.0);
                    }
                  },
                  icon: Icon(
                    _getVolumeIcon(audio.volume),
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: theme.sliderTheme.copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    ),
                    child: Slider(
                      value: audio.volume,
                      onChanged: (value) => audio.setVolume(value),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingSm),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${(audio.volume * 100).round()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getVolumeIcon(double volume) {
    if (volume <= 0) return Icons.volume_off_rounded;
    if (volume < 0.5) return Icons.volume_down_rounded;
    return Icons.volume_up_rounded;
  }
}