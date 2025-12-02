import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import '../../core/models/pane.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';
import '../../core/providers/settings_provider.dart';
import '../widgets/pane_container.dart';
import 'settings_screen.dart';

/// Main home screen with titlebar and pane container
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WindowListener {
  @override
  void initState() {
    super.initState();
    if (_isDesktop) {
      windowManager.addListener(this);
    }
  }

  @override
  void dispose() {
    if (_isDesktop) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  bool get _isDesktop =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  bool get _isMacOS => Platform.isMacOS;

  bool get _isMobile => !_isDesktop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // On mobile, wrap content in SafeArea to respect system UI
    Widget content = Column(
      children: [
        // Custom titlebar for desktop
        if (_isDesktop) _buildTitleBar(context, theme),

        // Main content - pane container
        Expanded(
          child: Consumer<SettingsProvider>(
            builder: (context, settings, child) {
              return Padding(
                padding: EdgeInsets.all(settings.borderSpacing),
                child: const PaneContainer(),
              );
            },
          ),
        ),
      ],
    );

    // Wrap in SafeArea only on mobile (iOS/Android)
    if (_isMobile) {
      final isDark = theme.brightness == Brightness.dark;
      final paneBackground = isDark
          ? Color.lerp(theme.colorScheme.surface, Colors.white, 0.05)!
          : Color.lerp(theme.colorScheme.surface, Colors.white, 0.7)!;

      content = Container(
        color: paneBackground,
        child: SafeArea(
          // Don't apply bottom padding - we handle that with tab bar
          bottom: false,
          child: content,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          content,
          
          // Fixed menu button right-aligned, bottom area (mobile only)
          if (_isMobile)
            Positioned(
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom,
              width: 64,
              height: 64,
              child: Center(
                child: _buildSettingsButton(context, theme),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTitleBar(BuildContext context, ThemeData theme) {
    return GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      child: Container(
        height: AppDimensions.titlebarHeight,
        color: Colors.transparent,
        child: Row(
          children: [
            // macOS puts window controls on left
            if (_isMacOS) ...[
              const SizedBox(width: 78), // Space for traffic lights
              const Spacer(),
              _buildEditControls(context, theme),
              const SizedBox(width: AppDimensions.spacingSm),
              _buildSettingsButton(context, theme),
              const SizedBox(width: AppDimensions.spacingSm),
            ] else ...[
              // Windows/Linux: settings on left, controls on right
              const SizedBox(width: AppDimensions.spacingSm),
              _buildSettingsButton(context, theme),
              const SizedBox(width: AppDimensions.spacingSm),
              _buildEditControls(context, theme),
              const Spacer(),
              _buildWindowControls(context, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEditControls(BuildContext context, ThemeData theme) {
    return Consumer<PaneProvider>(
      builder: (context, paneProvider, child) {
        if (!paneProvider.editMode) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () => _showAddPaneDialog(context),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text('Add a pane', style: theme.textTheme.bodySmall),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.onSurface,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => paneProvider.toggleRemoveMode(),
                icon: Icon(
                  paneProvider.removeMode ? Icons.close_rounded : Icons.remove_circle_outline_rounded,
                  size: 16,
                ),
                label: Text(
                  paneProvider.removeMode ? 'Done removing' : 'Remove a pane',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: paneProvider.removeMode ? theme.colorScheme.error : null,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: paneProvider.removeMode ? theme.colorScheme.error : theme.colorScheme.onSurface,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  backgroundColor: paneProvider.removeMode ? theme.colorScheme.errorContainer : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  OverlayEntry? _addPaneOverlayEntry;

  void _showAddPaneDialog(BuildContext context) {
    // Remove existing overlay if any
    _addPaneOverlayEntry?.remove();
    
    final overlay = Overlay.of(context);
    
    _addPaneOverlayEntry = OverlayEntry(
      builder: (context) => _AddPaneOverlay(
        onClose: () {
          _addPaneOverlayEntry?.remove();
          _addPaneOverlayEntry = null;
        },
      ),
    );
    
    overlay.insert(_addPaneOverlayEntry!);
  }

  Widget _buildSettingsButton(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.menu_rounded),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        iconSize: 20,
        tooltip: 'Menu',
        color: theme.colorScheme.surface,
        onSelected: (value) {
          switch (value) {
            case 'settings':
              _openSettings(context);
              break;
            case 'edit_mode':
              context.read<PaneProvider>().toggleEditMode();
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit_mode',
            child: Consumer<PaneProvider>(
              builder: (context, paneProvider, child) {
                return Row(
                  children: [
                    Icon(
                      paneProvider.editMode ? Icons.lock_open_rounded : Icons.edit_rounded,
                      size: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      paneProvider.editMode ? 'Exit Edit Mode' : 'Edit Mode',
                      style: TextStyle(color: theme.colorScheme.onSurface),
                    ),
                  ],
                );
              },
            ),
          ),
          PopupMenuItem(
            value: 'settings',
            child: Row(
              children: [
                Icon(
                  Icons.settings_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(width: 12),
                Text(
                  'Settings',
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowControls(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowButton(
          icon: Icons.remove_rounded,
          onPressed: () => windowManager.minimize(),
          tooltip: 'Minimize',
        ),
        _WindowButton(
          icon: Icons.crop_square_rounded,
          onPressed: () async {
            if (await windowManager.isMaximized()) {
              await windowManager.unmaximize();
            } else {
              await windowManager.maximize();
            }
          },
          tooltip: 'Maximize',
        ),
        _WindowButton(
          icon: Icons.close_rounded,
          onPressed: () => windowManager.close(),
          tooltip: 'Close',
          isClose: true,
        ),
      ],
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final bool isClose;

  const _WindowButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isClose = false,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Tooltip(
          message: widget.tooltip,
          child: Container(
            width: 46,
            height: AppDimensions.titlebarHeight,
            color: _isHovering
                ? (widget.isClose
                    ? Colors.red
                    : theme.colorScheme.onSurface.withValues(alpha: 0.1))
                : Colors.transparent,
            child: Icon(
              widget.icon,
              size: 16,
              color: _isHovering && widget.isClose
                  ? Colors.white
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _AddPaneOverlay extends StatelessWidget {
  final VoidCallback onClose;
  
  const _AddPaneOverlay({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Positioned(
      top: AppDimensions.titlebarHeight + 8,
      right: 8,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        color: theme.colorScheme.surface,
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add pane', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(
                        'Drag to desired location',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: onClose,
                    iconSize: 20,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildDraggableItem(context, 'Library', PaneType.library, Icons.library_music_rounded),
              _buildDraggableItem(context, 'Playing', PaneType.nowPlaying, Icons.album_rounded),
              _buildDraggableItem(context, 'Queue', PaneType.queue, Icons.queue_music_rounded),
              _buildDraggableItem(context, 'Selection', PaneType.selection, Icons.checklist_rounded),
              _buildDraggableItem(context, 'Seekbar', PaneType.seekbar, Icons.linear_scale_rounded),
              _buildDraggableItem(context, 'Controls', PaneType.controls, Icons.skip_next_rounded),
              _buildDraggableItem(context, 'Album Cover', PaneType.albumCover, Icons.album_rounded),
              _buildDraggableItem(context, 'Volume', PaneType.volume, Icons.volume_up_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableItem(BuildContext context, String title, PaneType type, IconData icon) {
    final theme = Theme.of(context);
    
    final feedback = Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      color: theme.colorScheme.surface,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(title, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );

    return Draggable<Map<String, dynamic>>(
      data: {
        'type': 'new_pane',
        'paneType': type,
        'title': title,
      },
      feedback: feedback,
      onDragStarted: () => onClose(),
      child: InkWell(
        onTap: () {}, // Needed for hover effect
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(child: Text(title)),
              Icon(Icons.drag_indicator_rounded, size: 20, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}