import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/pane.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/models/app_settings.dart';

/// Tab bar for a pane with drag-and-drop support
/// Tabs float above the pane content area
class PaneTabBar extends StatefulWidget {
  final String paneId;
  final List<PaneTab> tabs;
  final int activeIndex;
  final bool editMode;
  final bool showDragBar;
  final bool isMobile;
  final Color paneBackgroundColor;
  final double borderSpacing;
  final ValueChanged<int> onTabSelected;
  final ValueChanged<String>? onTabClose;
  final Function(String tabId, String targetPaneId)? onTabDroppedToPane;
  final VoidCallback? onContextMenu;
  
  const PaneTabBar({
    super.key,
    required this.paneId,
    required this.tabs,
    required this.activeIndex,
    required this.editMode,
    required this.onTabSelected,
    required this.paneBackgroundColor,
    required this.borderSpacing,
    this.showDragBar = false,
    this.isMobile = false,
    this.onTabClose,
    this.onTabDroppedToPane,
    this.onContextMenu,
  });

  @override
  State<PaneTabBar> createState() => _PaneTabBarState();
}

class _PaneTabBarState extends State<PaneTabBar> {
  int? _dragIndex;
  int? _dragTargetIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>();
    final hasMultipleTabs = widget.tabs.length > 1;
    
    // Use the isMobile flag passed from parent (detected by Platform)
    final isMobile = widget.isMobile;
    final tabPosition = isMobile ? PaneTabPosition.bottom : settings.tabPosition;
    final tabAlignment = isMobile ? PaneTabAlignment.center : settings.tabAlignment;

    // If not in edit mode and only one tab, hide the tab bar
    if (!widget.editMode && !hasMultipleTabs) {
      return const SizedBox.shrink();
    }

    // If in edit mode and only one tab, show centered floating pill drag bar
    if (widget.editMode && !hasMultipleTabs) {
      return Container(
        height: AppDimensions.paneTabHeight,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          bottom: tabPosition == PaneTabPosition.top ? widget.borderSpacing : 0,
          top: tabPosition == PaneTabPosition.bottom ? widget.borderSpacing : 0,
        ),
        child: _buildDragBar(theme),
      );
    }

    // Build tab widgets list
    final tabWidgets = <Widget>[];
    for (var index = 0; index < widget.tabs.length; index++) {
      final tab = widget.tabs[index];
      final isActive = index == widget.activeIndex;
      tabWidgets.add(
        _buildTab(
          tab: tab,
          index: index,
          isActive: isActive,
          theme: theme,
          isMobile: isMobile,
        ),
      );
    }

    Widget content = Container(
      height: isMobile ? 64 : AppDimensions.paneTabHeight,
      // Transparent background - tabs float over it
      color: Colors.transparent,
      margin: EdgeInsets.only(
        bottom: tabPosition == PaneTabPosition.top ? widget.borderSpacing : 0,
        top: tabPosition == PaneTabPosition.bottom ? widget.borderSpacing : 0,
      ),
      child: Row(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        mainAxisAlignment: tabAlignment == PaneTabAlignment.center 
            ? MainAxisAlignment.center 
            : MainAxisAlignment.start,
        children: [
          // Drag bar when in edit mode and single tab (shouldn't happen here due to check above)
          if (widget.editMode && widget.showDragBar && !hasMultipleTabs)
            _buildDragBar(theme),

          // Tabs
          if (tabAlignment == PaneTabAlignment.center)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
                children: tabWidgets,
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
                  children: tabWidgets,
                ),
              ),
            ),
        ],
      ),
    );

    return GestureDetector(
      onSecondaryTap: widget.onContextMenu,
      onLongPress: widget.onContextMenu,
      child: content,
    );
  }

  Widget _buildDragBar(ThemeData theme) {
    return Draggable<Map<String, dynamic>>(
      data: {
        'type': 'pane',
        'tabId': widget.tabs.first.id,
      },
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: Text(
            widget.tabs.first.title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 48,
        height: 24,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        child: Container(
          width: 48,
          height: 24,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.drag_handle,
            size: 16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required PaneTab tab,
    required int index,
    required bool isActive,
    required ThemeData theme,
    required bool isMobile,
  }) {
    final isDragging = _dragIndex == index;
    final isDark = theme.brightness == Brightness.dark;

    // Tab colors:
    // - Active: matches pane background (solid)
    // - Inactive: darker, more transparent
    final activeColor = widget.paneBackgroundColor;
    final inactiveColor = isDark
        ? Colors.black.withValues(alpha: 0.2)
        : Colors.black.withValues(alpha: 0.05);

    // Drop indicator line
    final showLeftLine = _dragTargetIndex == index && !isDragging;
    final showRightLine = _dragTargetIndex == index + 1 && !isDragging;

    Widget tabContent = Container(
      margin: EdgeInsets.only(
        left: index == 0 ? 0 : 4,
        right: 4,
      ),
      decoration: isMobile 
          ? null // No background for mobile tabs
          : BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: widget.borderSpacing == 0
                  ? const BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusMd))
                  : BorderRadius.circular(AppDimensions.radiusMd),
            ),
      child: Stack(
        children: [
          Padding(
            padding: isMobile 
                ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: isMobile
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getIconForPaneType(tab.type),
                        size: 24,
                        color: isActive
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tab.title,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isActive
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getIconForPaneType(tab.type),
                        size: 16,
                        color: isActive
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tab.title,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isActive
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                      if (widget.editMode && widget.tabs.length > 1) ...[
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () => widget.onTabClose?.call(tab.id),
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
          if (showLeftLine)
            Positioned(
              left: 0,
              top: 4,
              bottom: 4,
              width: 2,
              child: Container(
                color: theme.colorScheme.primary,
              ),
            ),
          if (showRightLine)
            Positioned(
              right: 0,
              top: 4,
              bottom: 4,
              width: 2,
              child: Container(
                color: theme.colorScheme.primary,
              ),
            ),
        ],
      ),
    );

    Widget tabWidget = GestureDetector(
      onTap: () => widget.onTabSelected(index),
      onSecondaryTap: widget.onContextMenu,
      onLongPress: widget.onContextMenu,
      child: tabContent,
    );

    // Make tabs draggable in edit mode
    if (widget.editMode) {
      // Use a GlobalKey to get the render box for hit testing
      final tabKey = GlobalKey();
      
      return DragTarget<Map<String, dynamic>>(
        key: ValueKey('drop_${tab.id}'),
        onWillAcceptWithDetails: (details) {
          final data = details.data;
          return data['type'] == 'tab' && data['tabId'] != tab.id;
        },
        onMove: (details) {
          final renderObject = tabKey.currentContext?.findRenderObject();
          if (renderObject is! RenderBox) return;
          
          final localPos = renderObject.globalToLocal(details.offset);
          final isRightHalf = localPos.dx > renderObject.size.width / 2;
          
          final targetIndex = isRightHalf ? index + 1 : index;
          
          if (_dragTargetIndex != targetIndex) {
            setState(() => _dragTargetIndex = targetIndex);
          }
        },
        onLeave: (_) {
          if (_dragTargetIndex == index || _dragTargetIndex == index + 1) {
            setState(() => _dragTargetIndex = null);
          }
        },
        onAcceptWithDetails: (details) {
          final data = details.data;
          if (data['type'] == 'tab' && _dragIndex != null && _dragTargetIndex != null) {
            context.read<PaneProvider>().reorderTab(
              widget.paneId,
              _dragIndex!,
              _dragTargetIndex!,
            );
          }
          setState(() {
            _dragIndex = null;
            _dragTargetIndex = null;
          });
        },
        builder: (context, candidateData, rejectedData) {
          return Draggable<Map<String, dynamic>>(
            key: ValueKey('drag_${tab.id}'),
            data: {
              'type': 'tab',
              'tabId': tab.id,
            },
            onDragStarted: () => setState(() => _dragIndex = index),
            onDragEnd: (_) => setState(() {
              _dragIndex = null;
              _dragTargetIndex = null;
            }),
            feedback: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForPaneType(tab.type),
                      size: 16,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tab.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Container(key: tabKey, child: tabWidget),
            ),
            child: Container(key: tabKey, child: tabWidget),
          );
        },
      );
    }

    return tabWidget;
  }

  IconData _getIconForPaneType(PaneType type) {
    switch (type) {
      case PaneType.nowPlaying:
        return Icons.album;
      case PaneType.library:
        return Icons.library_music;
      case PaneType.queue:
        return Icons.queue_music;
      case PaneType.custom:
        return Icons.extension;
    }
  }
}