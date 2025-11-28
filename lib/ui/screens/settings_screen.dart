import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';

/// Global settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            children: [
              // Library Section
              _buildSectionHeader(context, 'Library', theme),
              _buildLibrarySection(context, settings, theme),
              
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
                icon: const Icon(Icons.add),
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
        Icons.folder,
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
            icon: const Icon(Icons.delete_outline),
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
                          Icons.check,
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
                icon: Icon(Icons.brightness_auto),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Light'),
                icon: Icon(Icons.brightness_high),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Dark'),
                icon: Icon(Icons.brightness_2),
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
          SwitchListTile(
            title: const Text('Edit Mode'),
            subtitle: const Text('Enable to rearrange panes'),
            value: paneProvider.editMode,
            onChanged: (value) => paneProvider.setEditMode(value),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: AppDimensions.spacingMd),
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
          ListTile(
            leading: const Icon(Icons.restore),
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