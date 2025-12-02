import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/pane.dart';
import '../../core/models/app_settings.dart';
import '../../core/providers/pane_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/library_provider.dart';
import '../../theme/app_theme.dart';
import 'pane_tab_bar.dart';
import 'custom_menu.dart';
import '../panes/base_pane.dart';
import '../panes/now_playing_pane.dart';
import '../panes/library_pane.dart';
import '../panes/queue_pane.dart';
import '../panes/selection_pane.dart';

/// Widget that displays a single pane with its tab bar and content
class PaneWidget extends StatefulWidget {
  final Pane pane;
  final bool editMode;

  const PaneWidget({
    super.key,
    required this.pane,
    required this.editMode,
  });

  @override
  State<PaneWidget> createState() => _PaneWidgetState();
}

class _PaneWidgetState extends State<PaneWidget> {
  DropPosition? _dropPosition;

  // Detect mobile by OS, not screen size
  bool get _isMobile => Platform.isIOS || Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paneProvider = context.read<PaneProvider>();
    final settings = context.watch<SettingsProvider>();
    final isDark = theme.brightness == Brightness.dark;
    
    // Determine layout based on platform (iOS/Android = mobile)
    final tabPosition = _isMobile ? PaneTabPosition.bottom : settings.tabPosition;

    // Pane background - slightly brighter than scaffold background
    final paneBackground = isDark
        ? Color.lerp(theme.colorScheme.surface, Colors.white, 0.05)!
        : Color.lerp(theme.colorScheme.surface, Colors.white, 0.7)!;

    return PopScope(
      canPop: widget.pane.activeTabIndex == 0,
      onPopInvoked: (didPop) {
        if (didPop) return;
        // Go to previous tab or first tab
        if (widget.pane.activeTabIndex > 0) {
          paneProvider.setActiveTab(widget.pane.id, 0);
        }
      },
      child: DragTarget<Map<String, dynamic>>(
      onWillAcceptWithDetails: (details) {
        if (!widget.editMode) return false;
        final data = details.data;
        // Don't accept drops from the same pane if it's the only tab
        if (data['tabId'] != null &&
            widget.pane.tabs.any((t) => t.id == data['tabId']) &&
            widget.pane.tabs.length == 1) {
          return false;
        }
        return true;
      },
      onAcceptWithDetails: (details) {
        final data = details.data;
        if (_dropPosition != null && data['tabId'] != null) {
          _handleDrop(paneProvider, data['tabId'] as String);
        }
        setState(() => _dropPosition = null);
      },
      onMove: (details) {
        if (!widget.editMode) return;
        final position = _calculateDropPosition(context, details.offset);
        if (position != _dropPosition) {
          setState(() => _dropPosition = position);
        }
      },
      onLeave: (_) => setState(() => _dropPosition = null),
      builder: (context, candidateData, rejectedData) {
        final tabBar = PaneTabBar(
          paneId: widget.pane.id,
          tabs: widget.pane.tabs,
          activeIndex: widget.pane.activeTabIndex,
          editMode: widget.editMode,
          showDragBar: widget.pane.tabs.length == 1,
          paneBackgroundColor: paneBackground,
          borderSpacing: _isMobile ? 0.0 : settings.borderSpacing,
          isMobile: _isMobile, // Pass mobile flag
          onTabSelected: (index) {
            paneProvider.setActiveTab(widget.pane.id, index);
          },
          onTabClose: (tabId) {
            paneProvider.removeTab(widget.pane.id, tabId);
          },
          onContextMenu: (position) {
            _showPaneContextMenu(context, position);
          },
        );

        final contentArea = Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: paneBackground,
              borderRadius: settings.borderSpacing == 0
                  ? BorderRadius.zero
                  : BorderRadius.circular(AppDimensions.radiusMd),
            ),
            clipBehavior: Clip.antiAlias,
            child: _buildContent(context),
          ),
        );

        return Stack(
          children: [
            // Main pane content - no borders, brighter background
            Column(
              children: tabPosition == PaneTabPosition.bottom
                  ? [
                      contentArea,
                      Container(
                        color: theme.scaffoldBackgroundColor,
                        child: SafeArea(top: false, child: tabBar),
                      ),
                    ]
                  : [tabBar, contentArea],
            ),

            // Drop zone indicators (allow on mobile now)
            if (widget.editMode && candidateData.isNotEmpty)
              _buildDropIndicators(theme),
          ],
        );
      },
    ));
  }

  Widget _buildContent(BuildContext context) {
    final tabs = widget.pane.tabs;
    final activeIndex = widget.pane.activeTabIndex;
    
    if (tabs.isEmpty) {
      return const Center(child: Text('No tab selected'));
    }

    // Use IndexedStack to keep all tab widgets in memory
    return GestureDetector(
      onSecondaryTapUp: (details) => _showPaneContextMenu(context, details.globalPosition),
      onLongPressStart: (details) => _showPaneContextMenu(context, details.globalPosition),
      child: IndexedStack(
        index: activeIndex,
        children: tabs.map((tab) => _buildPaneContent(tab)).toList(),
      ),
    );
  }

  Widget _buildPaneContent(PaneTab tab) {
    switch (tab.type) {
      case PaneType.nowPlaying:
        return NowPlayingPane(
          key: ValueKey('nowplaying_${tab.id}'),
          settings: tab.settings,
        );
      case PaneType.library:
        return LibraryPane(
          key: ValueKey('library_${tab.id}'),
          paneId: widget.pane.id,
          tabId: tab.id,
          settings: tab.settings,
        );
      case PaneType.queue:
        return QueuePane(key: ValueKey('queue_${tab.id}'));
      case PaneType.selection:
        return SelectionPane(key: ValueKey('selection_${tab.id}'));
      case PaneType.custom:
        return BasePaneContent(
          key: ValueKey('custom_${tab.id}'),
          title: tab.title,
          child: Center(child: Text('Custom pane: ${tab.title}')),
        );
    }
  }

  DropPosition _calculateDropPosition(BuildContext context, Offset globalOffset) {
    final box = context.findRenderObject() as RenderBox;
    final localOffset = box.globalToLocal(globalOffset);
    final size = box.size;

    const edgeThreshold = 50.0;

    if (localOffset.dx < edgeThreshold) {
      return DropPosition.left;
    } else if (localOffset.dx > size.width - edgeThreshold) {
      return DropPosition.right;
    } else if (localOffset.dy < edgeThreshold + AppDimensions.paneTabHeight) {
      return DropPosition.top;
    } else if (localOffset.dy > size.height - edgeThreshold) {
      return DropPosition.bottom;
    }
    return DropPosition.center;
  }

  Widget _buildDropIndicators(ThemeData theme) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          child: _buildDropIndicator(theme),
        ),
      ),
    );
  }

  Widget _buildDropIndicator(ThemeData theme) {
    final color = theme.colorScheme.primary.withValues(alpha: 0.2);
    final highlightColor = theme.colorScheme.primary.withValues(alpha: 0.4);

    switch (_dropPosition) {
      case DropPosition.left:
        return Row(
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.radiusMd),
                  bottomLeft: Radius.circular(AppDimensions.radiusMd),
                ),
              ),
              child: Center(
                child: Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      case DropPosition.right:
        return Row(
          children: [
            const Spacer(),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppDimensions.radiusMd),
                  bottomRight: Radius.circular(AppDimensions.radiusMd),
                ),
              ),
              child: Center(
                child: Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        );
      case DropPosition.top:
        return Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.radiusMd),
                  topRight: Radius.circular(AppDimensions.radiusMd),
                ),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      case DropPosition.bottom:
        return Column(
          children: [
            const Spacer(),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppDimensions.radiusMd),
                  bottomRight: Radius.circular(AppDimensions.radiusMd),
                ),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        );
      case DropPosition.center:
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        );
      case null:
        return const SizedBox.shrink();
    }
  }

  void _handleDrop(PaneProvider paneProvider, String tabId) {
    switch (_dropPosition) {
      case DropPosition.left:
        // Create new pane to the left
        _splitPaneWithTab(paneProvider, tabId, SplitDirection.horizontal, true);
        break;
      case DropPosition.right:
        // Create new pane to the right
        _splitPaneWithTab(paneProvider, tabId, SplitDirection.horizontal, false);
        break;
      case DropPosition.top:
        // Create new pane above
        _splitPaneWithTab(paneProvider, tabId, SplitDirection.vertical, true);
        break;
      case DropPosition.bottom:
        // Create new pane below
        _splitPaneWithTab(paneProvider, tabId, SplitDirection.vertical, false);
        break;
      case DropPosition.center:
        // Add tab to this pane
        _moveTabToPane(paneProvider, tabId);
        break;
      case null:
        break;
    }
  }

  void _splitPaneWithTab(
    PaneProvider paneProvider,
    String tabId,
    SplitDirection direction,
    bool insertFirst,
  ) {
    // Find the tab being dropped
    final allPanes = _getAllPanes(paneProvider.layout.root);
    PaneTab? sourceTab;
    String? sourcePaneId;

    for (final pane in allPanes) {
      for (final tab in pane.tabs) {
        if (tab.id == tabId) {
          sourceTab = tab;
          sourcePaneId = pane.id;
          break;
        }
      }
      if (sourceTab != null) break;
    }

    if (sourceTab == null || sourcePaneId == null) return;

    // Remove from source and create split
    paneProvider.removeTab(sourcePaneId, tabId);
    paneProvider.splitPane(
      paneId: widget.pane.id,
      direction: direction,
      newTab: sourceTab,
      insertFirst: insertFirst,
    );
  }

  void _moveTabToPane(PaneProvider paneProvider, String tabId) {
    // Find source pane
    final allPanes = _getAllPanes(paneProvider.layout.root);
    String? sourcePaneId;

    for (final pane in allPanes) {
      if (pane.tabs.any((t) => t.id == tabId)) {
        sourcePaneId = pane.id;
        break;
      }
    }

    if (sourcePaneId == null || sourcePaneId == widget.pane.id) return;

    paneProvider.moveTab(
      fromPaneId: sourcePaneId,
      tabId: tabId,
      toPaneId: widget.pane.id,
    );
  }

  List<Pane> _getAllPanes(PaneNode node) {
    if (node is PaneLeaf) {
      return [node.pane];
    } else if (node is PaneSplit) {
      return [..._getAllPanes(node.first), ..._getAllPanes(node.second)];
    }
    return [];
  }

  void _showPaneContextMenu(BuildContext context, [Offset? position]) {
    final paneProvider = context.read<PaneProvider>();
    final activeTab = widget.pane.activeTab;

    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final pos = position ?? overlay.localToGlobal(Offset.zero) + const Offset(100, 100);

    showFadeMenu<void>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(pos.dx, pos.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry<void>>[
        if (activeTab != null)
          PopupMenuItem<void>(
            child: const ListTile(
              leading: Icon(Icons.add_rounded),
              title: Text('Add Tab'),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onTap: () => _showAddTabDialog(context),
          ),
        const PopupMenuDivider(),
        PopupMenuItem<void>(
          child: ListTile(
            leading: Icon(
              paneProvider.editMode ? Icons.lock_rounded : Icons.edit_rounded,
            ),
            title: Text(
              paneProvider.editMode ? 'Exit Edit Mode' : 'Enter Edit Mode',
            ),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onTap: () => paneProvider.toggleEditMode(),
        ),
      ],
    );
  }

  void _showAddTabDialog(BuildContext context) {
    final paneProvider = context.read<PaneProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Tab'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.album_rounded),
              title: const Text('Playing'),
              onTap: () {
                paneProvider.addTab(
                  widget.pane.id,
                  PaneTab.create(title: 'Playing', type: PaneType.nowPlaying),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_music_rounded),
              title: const Text('Library'),
              onTap: () {
                paneProvider.addTab(
                  widget.pane.id,
                  PaneTab.create(title: 'Library', type: PaneType.library),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.queue_music_rounded),
              title: const Text('Queue'),
              onTap: () {
                paneProvider.addTab(
                  widget.pane.id,
                  PaneTab.create(title: 'Queue', type: PaneType.queue),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.checklist_rounded),
              title: const Text('Selection'),
              onTap: () {
                paneProvider.addTab(
                  widget.pane.id,
                  PaneTab.create(title: 'Selection', type: PaneType.selection),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

enum DropPosition {
  left,
  right,
  top,
  bottom,
  center,
}