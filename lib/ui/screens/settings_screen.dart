import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/models/app_settings.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/pane_provider.dart';
import '../../core/providers/library_provider.dart';
import '../../theme/app_theme.dart';

/// Global settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;
    
    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: isDesktop ? AppDimensions.titlebarHeight : 0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Consumer2<SettingsProvider, LibraryProvider>(
          builder: (context, settings, library, child) {
            return ListView(
              padding: const EdgeInsets.all(AppDimensions.spacingMd),
              children: [
                // Library Section
                _buildSectionHeader(context, 'Library', theme),
                _buildLibrarySection(context, settings, theme),
                
                const SizedBox(height: AppDimensions.spacingMd),
                
                // Library Scanning Section
                _buildLibraryScanSection(context, settings, library, theme),
                
                const SizedBox(height: AppDimensions.spacingLg),
                
                // Appearance Section
                _buildSectionHeader(context, 'Appearance', theme),
                _buildAppearanceSection(context, settings, theme),
                
                const SizedBox(height: AppDimensions.spacingLg),
                
                // Layout Section
                _buildSectionHeader(context, 'Layout', theme),
                _buildLayoutSection(context, theme),
              ],
            );
          },
        ),
    ),
  );
}

  Widget _buildSectionHeader(BuildContext context, String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingSm),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLibrarySection(
    BuildContext context,
    SettingsProvider settings,
    ThemeData theme,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final sectionBgColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    
    return Container(
      decoration: BoxDecoration(
        color: sectionBgColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Library Folders',
                style: theme.textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () => _addLibraryFolder(context, settings),
                icon: const Icon(Icons.add_rounded),
                tooltip: 'Add folder',
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          if (settings.libraryFolders.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingMd),
              child: Center(
                child: Text(
                  'No library folders added',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ...settings.libraryFolders.map((folder) => _buildFolderTile(
                  context,
                  folder,
                  settings,
                  theme,
                )),
        ],
      ),
    );
  }

  Widget _buildFolderTile(
    BuildContext context,
    String folder,
    SettingsProvider settings,
    ThemeData theme,
  ) {
    final isDefault = settings.defaultLibraryFolder == folder;
    final name = folder.split('/').last.split('\\').last;

    return ListTile(
      leading: Icon(
        Icons.folder_rounded,
        color: isDefault ? theme.colorScheme.primary : null,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: isDefault ? FontWeight.w500 : null,
        ),
      ),
      subtitle: Text(
        folder,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDefault)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                label: const Text('Default'),
                backgroundColor: theme.colorScheme.primaryContainer,
                labelStyle: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontSize: 12,
                ),
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          IconButton(
            onPressed: () => settings.removeLibraryFolder(folder),
            icon: const Icon(Icons.delete_outline_rounded),
            color: theme.colorScheme.error,
          ),
        ],
      ),
      onTap: () => settings.setDefaultLibraryFolder(folder),
    );
  }

  Future<void> _addLibraryFolder(
    BuildContext context,
    SettingsProvider settings,
  ) async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      await settings.addLibraryFolder(result);
    }
  }

  Widget _buildLibraryScanSection(
    BuildContext context,
    SettingsProvider settings,
    LibraryProvider library,
    ThemeData theme,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final sectionBgColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    
    final progress = library.scanProgress;
    final isScanning = library.isScanning;
    
    return Container(
      decoration: BoxDecoration(
        color: sectionBgColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Library Scanning',
                style: theme.textTheme.bodyLarge,
              ),
              if (isScanning)
                TextButton.icon(
                  onPressed: () => library.cancelScan(),
                  icon: Icon(
                    Icons.cancel_rounded,
                    size: 18,
                    color: theme.colorScheme.error,
                  ),
                  label: Text(
                    'Cancel',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                )
              else
                FilledButton.icon(
                  onPressed: settings.libraryFolders.isEmpty
                      ? null
                      : () => library.scanLibrary(settings.libraryFolders),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('Scan Library'),
                ),
            ],
          ),
          if (isScanning && progress != null) ...[
            const SizedBox(height: AppDimensions.spacingMd),
            LinearProgressIndicator(
              value: progress.progress,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              (progress.currentFile?.isNotEmpty ?? false)
                  ? 'Scanning: ${_truncateFileName(progress.currentFile!)}'
                  : 'Preparing...',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimensions.spacingXs),
            Text(
              '${progress.scannedFiles} of ${progress.totalFiles} files processed',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ] else if (!isScanning && progress != null && progress.isComplete) ...[
            const SizedBox(height: AppDimensions.spacingSm),
            Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppDimensions.spacingXs),
                Text(
                  'Scan complete: ${progress.scannedFiles} files processed',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ] else if (settings.libraryFolders.isEmpty) ...[
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Add library folders above to enable scanning',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: AppDimensions.spacingMd),
          // Database stats
          FutureBuilder<Map<String, int>>(
            future: library.getDatabaseStats(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              
              final stats = snapshot.data!;
              final tracks = stats['tracks'] ?? 0;
              final artists = stats['artists'] ?? 0;
              final albums = stats['albums'] ?? 0;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Library Statistics',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingSm),
                  Wrap(
                    spacing: AppDimensions.spacingMd,
                    runSpacing: AppDimensions.spacingSm,
                    children: [
                      _buildStatChip(context, Icons.music_note_rounded, '$tracks tracks', theme),
                      _buildStatChip(context, Icons.person_rounded, '$artists artists', theme),
                      _buildStatChip(context, Icons.album_rounded, '$albums albums', theme),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingMd),
                  TextButton.icon(
                    onPressed: () => _confirmClearCache(context, library),
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: theme.colorScheme.error,
                    ),
                    label: Text(
                      'Clear Database Cache',
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(
    BuildContext context,
    IconData icon,
    String label,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingSm,
        vertical: AppDimensions.spacingXs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _truncateFileName(String path) {
    final name = path.split('/').last.split('\\').last;
    if (name.length > 40) {
      return '${name.substring(0, 37)}...';
    }
    return name;
  }

  Future<void> _confirmClearCache(
    BuildContext context,
    LibraryProvider library,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Database Cache'),
        content: const Text(
          'This will remove all cached metadata and cover art. '
          'You will need to scan your library again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await library.clearCache();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Database cache cleared')),
        );
      }
    }
  }

  Widget _buildAppearanceSection(
    BuildContext context,
    SettingsProvider settings,
    ThemeData theme,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final sectionBgColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    
    return Container(
      decoration: BoxDecoration(
        color: sectionBgColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Color',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          Wrap(
            spacing: AppDimensions.spacingSm,
            runSpacing: AppDimensions.spacingSm,
            children: AppTheme.themeColors.map((color) {
              final isSelected = settings.themeColor.value == color.value;
              return InkWell(
                onTap: () => settings.setThemeColor(color),
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          color: color.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppDimensions.spacingLg),
          Text(
            'Theme Mode',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('System'),
                icon: Icon(Icons.brightness_auto_rounded),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.brightness_high_rounded),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.brightness_2_rounded),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (modes) {
              settings.setThemeMode(modes.first);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutSection(BuildContext context, ThemeData theme) {
    final paneProvider = context.read<PaneProvider>();
    final settings = context.watch<SettingsProvider>();
    final isDark = theme.brightness == Brightness.dark;
    final sectionBgColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    
    // Check if we're on desktop (show additional settings)
    final isDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;

    return Container(
      decoration: BoxDecoration(
        color: sectionBgColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pane Layout',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          
          
          // Tab Position - desktop only
          if (isDesktop) ...[
            Text(
              'Tab Position',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            SegmentedButton<PaneTabPosition>(
              segments: const [
                ButtonSegment(
                  value: PaneTabPosition.top,
                  label: Text('Top'),
                  icon: Icon(Icons.vertical_align_top_rounded),
                ),
                ButtonSegment(
                  value: PaneTabPosition.bottom,
                  label: Text('Bottom'),
                  icon: Icon(Icons.vertical_align_bottom_rounded),
                ),
              ],
              selected: {settings.tabPosition},
              onSelectionChanged: (positions) {
                settings.setTabPosition(positions.first);
              },
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            
            Text(
              'Tab Alignment',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            SegmentedButton<PaneTabAlignment>(
              segments: const [
                ButtonSegment(
                  value: PaneTabAlignment.left,
                  label: Text('Left'),
                  icon: Icon(Icons.format_align_left_rounded),
                ),
                ButtonSegment(
                  value: PaneTabAlignment.center,
                  label: Text('Center'),
                  icon: Icon(Icons.format_align_center_rounded),
                ),
              ],
              selected: {settings.tabAlignment},
              onSelectionChanged: (alignments) {
                settings.setTabAlignment(alignments.first);
              },
            ),
            const SizedBox(height: AppDimensions.spacingMd),
          ],
          
          if (isDesktop) ...[
            Text(
              'Border Spacing',
              style: theme.textTheme.bodyMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: settings.borderSpacing,
                    min: 0.0,
                    max: 24.0,
                    divisions: 24,
                    label: settings.borderSpacing.round().toString(),
                    onChanged: (value) => settings.setBorderSpacing(value),
                  ),
                ),
                Text(
                  '${settings.borderSpacing.round()}px',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingSm),
          ],
          ListTile(
            leading: const Icon(Icons.restore_rounded),
            title: const Text('Reset Layout'),
            subtitle: const Text('Restore default pane layout'),
            contentPadding: EdgeInsets.zero,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset Layout'),
                  content: const Text(
                    'Are you sure you want to reset the layout to default?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        paneProvider.resetLayout();
                        Navigator.pop(context);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}