import 'package:flutter/material.dart';

/// Global application settings
class AppSettings {
  final List<String> libraryFolders;
  final Color themeColor;
  final ThemeMode themeMode;
  final String? defaultLibraryFolder;
  final double borderSpacing;
  final PaneTabPosition tabPosition;
  final PaneTabAlignment tabAlignment;

  const AppSettings({
    this.libraryFolders = const [],
    this.themeColor = Colors.blue,
    this.themeMode = ThemeMode.system,
    this.defaultLibraryFolder,
    this.borderSpacing = 8.0,
    this.tabPosition = PaneTabPosition.top,
    this.tabAlignment = PaneTabAlignment.left,
  });

  AppSettings copyWith({
    List<String>? libraryFolders,
    Color? themeColor,
    ThemeMode? themeMode,
    String? defaultLibraryFolder,
    double? borderSpacing,
    PaneTabPosition? tabPosition,
    PaneTabAlignment? tabAlignment,
  }) {
    return AppSettings(
      libraryFolders: libraryFolders ?? this.libraryFolders,
      themeColor: themeColor ?? this.themeColor,
      themeMode: themeMode ?? this.themeMode,
      defaultLibraryFolder: defaultLibraryFolder ?? this.defaultLibraryFolder,
      borderSpacing: borderSpacing ?? this.borderSpacing,
      tabPosition: tabPosition ?? this.tabPosition,
      tabAlignment: tabAlignment ?? this.tabAlignment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'libraryFolders': libraryFolders,
      'themeColor': themeColor.value,
      'themeMode': themeMode.name,
      'defaultLibraryFolder': defaultLibraryFolder,
      'borderSpacing': borderSpacing,
      'tabPosition': tabPosition.name,
      'tabAlignment': tabAlignment.name,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      libraryFolders: List<String>.from(json['libraryFolders'] as List? ?? []),
      themeColor: Color(json['themeColor'] as int? ?? Colors.blue.value),
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      defaultLibraryFolder: json['defaultLibraryFolder'] as String?,
      borderSpacing: (json['borderSpacing'] as num?)?.toDouble() ?? 8.0,
      tabPosition: PaneTabPosition.values.firstWhere(
        (e) => e.name == json['tabPosition'],
        orElse: () => PaneTabPosition.top,
      ),
      tabAlignment: PaneTabAlignment.values.firstWhere(
        (e) => e.name == json['tabAlignment'],
        orElse: () => PaneTabAlignment.left,
      ),
    );
  }
}

enum PaneTabPosition { top, bottom }
enum PaneTabAlignment { left, center }