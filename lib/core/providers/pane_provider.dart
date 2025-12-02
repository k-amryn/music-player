import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/pane.dart';
import '../services/storage_service.dart';

/// Provider for managing the pane layout
class PaneProvider extends ChangeNotifier {
  final StorageService? _storageService;
  PaneLayout _layout;
  
  /// Whether we're on a mobile platform (iOS/Android)
  static bool get isMobile => Platform.isIOS || Platform.isAndroid;

  PaneProvider(this._storageService, [PaneLayout? initialLayout])
      : _layout = initialLayout ?? _initLayout(_storageService);

  /// Initialize layout based on platform
  static PaneLayout _initLayout(StorageService? storageService) {
    if (isMobile) {
      // Mobile always uses mobile layout (single pane with tabs)
      return PaneLayout.mobileLayout();
    }
    if (storageService == null) {
      return PaneLayout.defaultLayout();
    }
    final layout = storageService.loadLayout();
    return _sanitizeLayout(layout);
  }

  static PaneLayout _sanitizeLayout(PaneLayout layout) {
    return layout.copyWith(
      root: _sanitizeNode(layout.root),
    );
  }

  static PaneNode _sanitizeNode(PaneNode node) {
    if (node is PaneLeaf) {
      return PaneLeaf(
        pane: node.pane.copyWith(
          tabs: node.pane.tabs.map((tab) {
            if (tab.title == 'Now Playing') {
              return tab.copyWith(title: 'Playing');
            }
            return tab;
          }).toList(),
        ),
      );
    } else if (node is PaneSplit) {
      return node.copyWith(
        first: _sanitizeNode(node.first),
        second: _sanitizeNode(node.second),
      );
    }
    return node;
  }

  PaneLayout get layout => _layout;
  bool get editMode => _layout.editMode;
  
  bool _removeMode = false;
  bool get removeMode => _removeMode;

  /// Toggle edit mode
  void toggleEditMode() {
    _layout = _layout.copyWith(editMode: !_layout.editMode);
    if (!_layout.editMode) {
      _removeMode = false;
    }
    _save();
    notifyListeners();
  }

  /// Toggle remove mode
  void toggleRemoveMode() {
    _removeMode = !_removeMode;
    notifyListeners();
  }

  /// Remove a pane by ID
  void removePane(String paneId) {
    final newRoot = _removePaneFromNode(_layout.root, paneId);
    if (newRoot != null) {
      _layout = _layout.copyWith(root: newRoot);
    } else {
      // If root is null, we removed the last pane. Reset to default.
      _layout = PaneLayout(
        root: _createDefaultPane(),
        editMode: _layout.editMode,
      );
    }
    _save();
    notifyListeners();
  }

  PaneNode? _removePaneFromNode(PaneNode node, String paneId) {
    if (node is PaneLeaf) {
      if (node.pane.id == paneId) {
        return null; // Remove this leaf
      }
      return node;
    } else if (node is PaneSplit) {
      final newFirst = _removePaneFromNode(node.first, paneId);
      final newSecond = _removePaneFromNode(node.second, paneId);

      if (newFirst == null && newSecond == null) return null;
      if (newFirst == null) return newSecond;
      if (newSecond == null) return newFirst;

      return node.copyWith(first: newFirst, second: newSecond);
    }
    return node;
  }

  /// Set edit mode
  void setEditMode(bool enabled) {
    _layout = _layout.copyWith(editMode: enabled);
    _save();
    notifyListeners();
  }

  /// Update the entire layout
  void updateLayout(PaneLayout newLayout) {
    _layout = newLayout;
    _save();
    notifyListeners();
  }

  /// Update a split ratio
  void updateSplitRatio(List<int> path, double ratio) {
    _layout = _layout.copyWith(
      root: _updateSplitRatioAt(_layout.root, path, 0, ratio),
    );
    _save();
    notifyListeners();
  }

  PaneNode _updateSplitRatioAt(
    PaneNode node,
    List<int> path,
    int pathIndex,
    double ratio,
  ) {
    if (pathIndex >= path.length) {
      if (node is PaneSplit) {
        return node.copyWith(ratio: ratio.clamp(0.1, 0.9));
      }
      return node;
    }

    if (node is PaneSplit) {
      final direction = path[pathIndex];
      if (direction == 0) {
        return node.copyWith(
          first: _updateSplitRatioAt(node.first, path, pathIndex + 1, ratio),
        );
      } else {
        return node.copyWith(
          second: _updateSplitRatioAt(node.second, path, pathIndex + 1, ratio),
        );
      }
    }
    
    return node;
  }

  /// Update the active tab of a pane
  void setActiveTab(String paneId, int tabIndex) {
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, paneId, (pane) {
        return pane.copyWith(
          activeTabIndex: tabIndex.clamp(0, pane.tabs.length - 1),
        );
      }),
    );
    notifyListeners();
  }

  /// Add a tab to a pane
  void addTab(String paneId, PaneTab tab) {
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, paneId, (pane) {
        return pane.addTab(tab);
      }),
    );
    _save();
    notifyListeners();
  }

  /// Remove a tab from a pane
  void removeTab(String paneId, String tabId) {
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, paneId, (pane) {
        return pane.removeTab(tabId);
      }),
    );
    // Clean up empty panes
    _layout = _layout.copyWith(
      root: _cleanupEmptyPanes(_layout.root) ?? _createDefaultPane(),
    );
    _save();
    notifyListeners();
  }

  /// Update tab settings
  void updateTabSettings(String paneId, String tabId, Map<String, dynamic> settings) {
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, paneId, (pane) {
        return pane.copyWith(
          tabs: pane.tabs.map((tab) {
            if (tab.id == tabId) {
              return tab.copyWith(settings: {...tab.settings, ...settings});
            }
            return tab;
          }).toList(),
        );
      }),
    );
    _save();
    notifyListeners();
  }

  /// Reorder tabs within a pane
  void reorderTab(String paneId, int oldIndex, int newIndex) {
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, paneId, (pane) {
        if (oldIndex < 0 || oldIndex >= pane.tabs.length) return pane;
        if (newIndex < 0 || newIndex >= pane.tabs.length) return pane;
        
        final newTabs = List<PaneTab>.from(pane.tabs);
        final tab = newTabs.removeAt(oldIndex);
        newTabs.insert(newIndex, tab);
        
        // Adjust active tab index
        int newActiveIndex = pane.activeTabIndex;
        if (oldIndex == pane.activeTabIndex) {
          newActiveIndex = newIndex;
        } else if (oldIndex < pane.activeTabIndex && newIndex >= pane.activeTabIndex) {
          newActiveIndex--;
        } else if (oldIndex > pane.activeTabIndex && newIndex <= pane.activeTabIndex) {
          newActiveIndex++;
        }
        
        return pane.copyWith(
          tabs: newTabs,
          activeTabIndex: newActiveIndex,
        );
      }),
    );
    _save();
    notifyListeners();
  }

  /// Move a tab from one pane to another
  void moveTab({
    required String fromPaneId,
    required String tabId,
    required String toPaneId,
    int? insertIndex,
  }) {
    PaneTab? movedTab;
    
    // Remove tab from source pane
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, fromPaneId, (pane) {
        movedTab = pane.tabs.firstWhere((t) => t.id == tabId);
        return pane.removeTab(tabId);
      }),
    );
    
    if (movedTab == null) return;
    
    // Add tab to destination pane
    _layout = _layout.copyWith(
      root: _updatePaneAt(_layout.root, toPaneId, (pane) {
        final newTabs = List<PaneTab>.from(pane.tabs);
        final index = insertIndex ?? newTabs.length;
        newTabs.insert(index.clamp(0, newTabs.length), movedTab!);
        return pane.copyWith(
          tabs: newTabs,
          activeTabIndex: index.clamp(0, newTabs.length - 1),
        );
      }),
    );
    
    // Clean up empty panes
    _layout = _layout.copyWith(
      root: _cleanupEmptyPanes(_layout.root) ?? _createDefaultPane(),
    );
    
    _save();
    notifyListeners();
  }

  /// Split a pane
  void splitPane({
    required String paneId,
    required SplitDirection direction,
    required PaneTab newTab,
    bool insertFirst = false,
  }) {
    _layout = _layout.copyWith(
      root: _splitPaneAt(_layout.root, paneId, direction, newTab, insertFirst),
    );
    _save();
    notifyListeners();
  }

  PaneNode _splitPaneAt(
    PaneNode node,
    String paneId,
    SplitDirection direction,
    PaneTab newTab,
    bool insertFirst,
  ) {
    if (node is PaneLeaf) {
      if (node.pane.id == paneId) {
        final newPane = Pane.create(tabs: [newTab]);
        if (insertFirst) {
          return PaneSplit(
            direction: direction,
            first: PaneLeaf(pane: newPane),
            second: node,
          );
        } else {
          return PaneSplit(
            direction: direction,
            first: node,
            second: PaneLeaf(pane: newPane),
          );
        }
      }
      return node;
    } else if (node is PaneSplit) {
      return node.copyWith(
        first: _splitPaneAt(node.first, paneId, direction, newTab, insertFirst),
        second: _splitPaneAt(node.second, paneId, direction, newTab, insertFirst),
      );
    }
    return node;
  }

  PaneNode _updatePaneAt(
    PaneNode node,
    String paneId,
    Pane Function(Pane pane) updater,
  ) {
    if (node is PaneLeaf) {
      if (node.pane.id == paneId) {
        return PaneLeaf(pane: updater(node.pane));
      }
      return node;
    } else if (node is PaneSplit) {
      return node.copyWith(
        first: _updatePaneAt(node.first, paneId, updater),
        second: _updatePaneAt(node.second, paneId, updater),
      );
    }
    return node;
  }

  PaneNode? _cleanupEmptyPanes(PaneNode node) {
    if (node is PaneLeaf) {
      if (node.pane.tabs.isEmpty) {
        return null;
      }
      return node;
    } else if (node is PaneSplit) {
      final first = _cleanupEmptyPanes(node.first);
      final second = _cleanupEmptyPanes(node.second);
      
      if (first == null && second == null) return null;
      if (first == null) return second;
      if (second == null) return first;
      
      return node.copyWith(first: first, second: second);
    }
    return node;
  }

  PaneLeaf _createDefaultPane() {
    return PaneLeaf(
      pane: Pane.create(
        tabs: [
          PaneTab.create(title: 'Library', type: PaneType.library),
        ],
      ),
    );
  }

  /// Find a pane by ID
  Pane? findPane(String paneId) {
    return _findPaneIn(_layout.root, paneId);
  }

  Pane? _findPaneIn(PaneNode node, String paneId) {
    if (node is PaneLeaf) {
      if (node.pane.id == paneId) return node.pane;
      return null;
    } else if (node is PaneSplit) {
      return _findPaneIn(node.first, paneId) ?? _findPaneIn(node.second, paneId);
    }
    return null;
  }

  /// Reset to default layout
  void resetLayout() {
    _layout = isMobile ? PaneLayout.mobileLayout() : PaneLayout.defaultLayout();
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    if (_storageService != null) {
      await _storageService.saveLayout(_layout);
    }
  }
}