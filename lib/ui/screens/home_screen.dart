import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
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
              _buildSettingsButton(context, theme),
              const Spacer(),
              const SizedBox(width: AppDimensions.spacingSm),
            ] else ...[
              // Windows/Linux: settings on left, controls on right
              const SizedBox(width: AppDimensions.spacingSm),
              _buildSettingsButton(context, theme),
              const Spacer(),
              _buildWindowControls(context, theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context, ThemeData theme) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu_rounded),
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