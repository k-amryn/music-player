import 'package:flutter/material.dart';

/// Global application settings
class AppSettings {
  final List<String> libraryFolders;
  final Color themeColor;
  final ThemeMode themeMode;
  final String? defaultLibraryFolder;
  final double borderSpacing;

  const AppSettings({
    this.libraryFolders = const [],
    this.themeColor = Colors.blue,
    this.themeMode = ThemeMode.system,
    this.defaultLibraryFolder,
    this.borderSpacing = 8.0,
  });

  AppSettings copyWith({
    List<String>? libraryFolders,
    Color? themeColor,
    ThemeMode? themeMode,
    String? defaultLibraryFolder,
    double? borderSpacing,
  }) {
    return AppSettings(
      libraryFolders: libraryFolders ?? this.libraryFolders,
      themeColor: themeColor ?? this.themeColor,
      themeMode: themeMode ?? this.themeMode,
      defaultLibraryFolder: defaultLibraryFolder ?? this.defaultLibraryFolder,
      borderSpacing: borderSpacing ?? this.borderSpacing,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'libraryFolders': libraryFolders,
      'themeColor': themeColor.value,
      'themeMode': themeMode.name,
      'defaultLibraryFolder': defaultLibraryFolder,
      'borderSpacing': borderSpacing,
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
    );
  }
}