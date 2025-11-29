import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Types of built-in panes available in the app
enum PaneType {
  nowPlaying,
  library,
  queue,
  custom,
}

/// Configuration for a pane tab
@immutable
class PaneTab {
  final String id;
  final String title;
  final PaneType type;
  final Map<String, dynamic> settings;

  const PaneTab({
    required this.id,
    required this.title,
    required this.type,
    this.settings = const {},
  });

  factory PaneTab.create({
    required String title,
    required PaneType type,
    Map<String, dynamic> settings = const {},
  }) {
    return PaneTab(
      id: _uuid.v4(),
      title: title,
      type: type,
      settings: settings,
    );
  }

  PaneTab copyWith({
    String? id,
    String? title,
    PaneType? type,
    Map<String, dynamic>? settings,
  }) {
    return PaneTab(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      settings: settings ?? this.settings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.name,
      'settings': settings,
    };
  }

  factory PaneTab.fromJson(Map<String, dynamic> json) {
    return PaneTab(
      id: json['id'] as String,
      title: json['title'] as String,
      type: PaneType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PaneType.custom,
      ),
      settings: Map<String, dynamic>.from(json['settings'] as Map? ?? {}),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaneTab && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Represents a pane that contains tabs
@immutable
class Pane {
  final String id;
  final List<PaneTab> tabs;
  final int activeTabIndex;
  final double flex;

  const Pane({
    required this.id,
    required this.tabs,
    this.activeTabIndex = 0,
    this.flex = 1.0,
  });

  factory Pane.create({
    List<PaneTab>? tabs,
    int activeTabIndex = 0,
    double flex = 1.0,
  }) {
    return Pane(
      id: _uuid.v4(),
      tabs: tabs ?? [],
      activeTabIndex: activeTabIndex,
      flex: flex,
    );
  }

  PaneTab? get activeTab {
    if (tabs.isEmpty || activeTabIndex < 0 || activeTabIndex >= tabs.length) {
      return null;
    }
    return tabs[activeTabIndex];
  }

  bool get hasMultipleTabs => tabs.length > 1;

  Pane copyWith({
    String? id,
    List<PaneTab>? tabs,
    int? activeTabIndex,
    double? flex,
  }) {
    return Pane(
      id: id ?? this.id,
      tabs: tabs ?? this.tabs,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      flex: flex ?? this.flex,
    );
  }

  Pane addTab(PaneTab tab) {
    return copyWith(
      tabs: [...tabs, tab],
      activeTabIndex: tabs.length,
    );
  }

  Pane removeTab(String tabId) {
    final newTabs = tabs.where((t) => t.id != tabId).toList();
    final removedIndex = tabs.indexWhere((t) => t.id == tabId);
    int newActiveIndex = activeTabIndex;
    
    // Handle empty tabs case
    if (newTabs.isEmpty) {
      return copyWith(
        tabs: newTabs,
        activeTabIndex: 0,
      );
    }
    
    if (removedIndex <= activeTabIndex && activeTabIndex > 0) {
      newActiveIndex = activeTabIndex - 1;
    }
    
    if (newActiveIndex >= newTabs.length) {
      newActiveIndex = newTabs.length - 1;
    }
    
    // Ensure valid clamp range
    final maxIndex = newTabs.length > 0 ? newTabs.length - 1 : 0;
    return copyWith(
      tabs: newTabs,
      activeTabIndex: newActiveIndex.clamp(0, maxIndex),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tabs': tabs.map((t) => t.toJson()).toList(),
      'activeTabIndex': activeTabIndex,
      'flex': flex,
    };
  }

  factory Pane.fromJson(Map<String, dynamic> json) {
    return Pane(
      id: json['id'] as String,
      tabs: (json['tabs'] as List)
          .map((t) => PaneTab.fromJson(t as Map<String, dynamic>))
          .toList(),
      activeTabIndex: json['activeTabIndex'] as int? ?? 0,
      flex: (json['flex'] as num?)?.toDouble() ?? 1.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pane && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Direction of pane split
enum SplitDirection {
  horizontal,
  vertical,
}

/// A node in the pane tree - either a leaf (Pane) or a split
@immutable
abstract class PaneNode {
  const PaneNode();

  Map<String, dynamic> toJson();

  static PaneNode fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'leaf') {
      return PaneLeaf.fromJson(json);
    } else {
      return PaneSplit.fromJson(json);
    }
  }
}

/// A leaf node containing a single Pane
@immutable
class PaneLeaf extends PaneNode {
  final Pane pane;

  const PaneLeaf({required this.pane});

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'leaf',
      'pane': pane.toJson(),
    };
  }

  factory PaneLeaf.fromJson(Map<String, dynamic> json) {
    return PaneLeaf(
      pane: Pane.fromJson(json['pane'] as Map<String, dynamic>),
    );
  }
}

/// A split node containing two children
@immutable
class PaneSplit extends PaneNode {
  final SplitDirection direction;
  final PaneNode first;
  final PaneNode second;
  final double ratio; // 0.0 to 1.0, represents position of divider

  const PaneSplit({
    required this.direction,
    required this.first,
    required this.second,
    this.ratio = 0.5,
  });

  PaneSplit copyWith({
    SplitDirection? direction,
    PaneNode? first,
    PaneNode? second,
    double? ratio,
  }) {
    return PaneSplit(
      direction: direction ?? this.direction,
      first: first ?? this.first,
      second: second ?? this.second,
      ratio: ratio ?? this.ratio,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'split',
      'direction': direction.name,
      'first': first.toJson(),
      'second': second.toJson(),
      'ratio': ratio,
    };
  }

  factory PaneSplit.fromJson(Map<String, dynamic> json) {
    return PaneSplit(
      direction: SplitDirection.values.firstWhere(
        (e) => e.name == json['direction'],
        orElse: () => SplitDirection.horizontal,
      ),
      first: PaneNode.fromJson(json['first'] as Map<String, dynamic>),
      second: PaneNode.fromJson(json['second'] as Map<String, dynamic>),
      ratio: (json['ratio'] as num?)?.toDouble() ?? 0.5,
    );
  }
}

/// The complete pane layout configuration
@immutable
class PaneLayout {
  final PaneNode root;
  final bool editMode;

  const PaneLayout({
    required this.root,
    this.editMode = false,
  });

  factory PaneLayout.defaultLayout() {
    return PaneLayout(
      root: PaneSplit(
        direction: SplitDirection.horizontal,
        first: PaneLeaf(
          pane: Pane.create(
            tabs: [
              PaneTab.create(
                title: 'Library',
                type: PaneType.library,
              ),
            ],
            flex: 1.0,
          ),
        ),
        second: PaneSplit(
          direction: SplitDirection.vertical,
          first: PaneLeaf(
            pane: Pane.create(
              tabs: [
                PaneTab.create(
                  title: 'Playing',
                  type: PaneType.nowPlaying,
                ),
              ],
            ),
          ),
          second: PaneLeaf(
            pane: Pane.create(
              tabs: [
                PaneTab.create(
                  title: 'Queue',
                  type: PaneType.queue,
                ),
              ],
            ),
          ),
          ratio: 0.6,
        ),
        ratio: 0.3,
      ),
    );
  }

  /// Mobile layout - all panes as tabs in a single pane
  factory PaneLayout.mobileLayout() {
    return PaneLayout(
      root: PaneLeaf(
        pane: Pane.create(
          tabs: [
            PaneTab.create(
              title: 'Library',
              type: PaneType.library,
            ),
            PaneTab.create(
              title: 'Playing',
              type: PaneType.nowPlaying,
            ),
            PaneTab.create(
              title: 'Queue',
              type: PaneType.queue,
            ),
          ],
          activeTabIndex: 0,
        ),
      ),
      editMode: false, // Edit mode is always disabled on mobile
    );
  }

  PaneLayout copyWith({
    PaneNode? root,
    bool? editMode,
  }) {
    return PaneLayout(
      root: root ?? this.root,
      editMode: editMode ?? this.editMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'root': root.toJson(),
      'editMode': editMode,
    };
  }

  factory PaneLayout.fromJson(Map<String, dynamic> json) {
    return PaneLayout(
      root: PaneNode.fromJson(json['root'] as Map<String, dynamic>),
      editMode: json['editMode'] as bool? ?? false,
    );
  }
}