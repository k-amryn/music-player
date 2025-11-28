import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Custom titlebar for desktop
          if (_isDesktop) _buildTitleBar(context, theme),

          // Main content - pane container
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingSm),
              child: const PaneContainer(),
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
              _buildSettingsButton(context, theme),
              const Spacer(),
              _buildEditModeButton(context, theme),
              const SizedBox(width: AppDimensions.spacingSm),
            ] else ...[
              // Windows/Linux: settings on left, controls on right
              const SizedBox(width: AppDimensions.spacingSm),
              _buildSettingsButton(context, theme),
              const Spacer(),
              _buildEditModeButton(context, theme),
              _buildWindowControls(context, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context, ThemeData theme) {
    return IconButton(
      onPressed: () => _openSettings(context),
      icon: const Icon(Icons.settings),
      iconSize: 20,
      tooltip: 'Settings',
      color: theme.colorScheme.onSurface,
    );
  }

  Widget _buildEditModeButton(BuildContext context, ThemeData theme) {
    final paneProvider = context.watch<PaneProvider>();

    return TextButton.icon(
      onPressed: () => paneProvider.toggleEditMode(),
      icon: Icon(
        paneProvider.editMode ? Icons.lock_open : Icons.edit,
        size: 16,
      ),
      label: Text(
        paneProvider.editMode ? 'Done' : 'Edit',
        style: const TextStyle(fontSize: 12),
      ),
      style: TextButton.styleFrom(
        foregroundColor: paneProvider.editMode
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildWindowControls(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowButton(
          icon: Icons.remove,
          onPressed: () => windowManager.minimize(),
          tooltip: 'Minimize',
        ),
        _WindowButton(
          icon: Icons.crop_square,
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
          icon: Icons.close,
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