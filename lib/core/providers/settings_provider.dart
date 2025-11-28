import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../services/storage_service.dart';

/// Provider for app settings including theme and library folders
class SettingsProvider extends ChangeNotifier {
  final StorageService _storageService;
  AppSettings _settings;

  SettingsProvider(this._storageService)
      : _settings = _storageService.loadSettings();

  AppSettings get settings => _settings;
  
  // Theme getters
  Color get themeColor => _settings.themeColor;
  ThemeMode get themeMode => _settings.themeMode;
  
  // Library getters
  List<String> get libraryFolders => _settings.libraryFolders;
  String? get defaultLibraryFolder => _settings.defaultLibraryFolder;
  
  // Layout getters
  double get borderSpacing => _settings.borderSpacing;

  /// Update theme color
  Future<void> setThemeColor(Color color) async {
    _settings = _settings.copyWith(themeColor: color);
    await _save();
    notifyListeners();
  }

  /// Update theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _settings = _settings.copyWith(themeMode: mode);
    await _save();
    notifyListeners();
  }

  /// Add a library folder
  Future<void> addLibraryFolder(String path) async {
    if (_settings.libraryFolders.contains(path)) return;
    
    _settings = _settings.copyWith(
      libraryFolders: [..._settings.libraryFolders, path],
    );
    await _save();
    notifyListeners();
  }

  /// Remove a library folder
  Future<void> removeLibraryFolder(String path) async {
    _settings = _settings.copyWith(
      libraryFolders: _settings.libraryFolders.where((f) => f != path).toList(),
      defaultLibraryFolder: _settings.defaultLibraryFolder == path 
          ? null 
          : _settings.defaultLibraryFolder,
    );
    await _save();
    notifyListeners();
  }

  /// Set default library folder
  Future<void> setDefaultLibraryFolder(String? path) async {
    _settings = _settings.copyWith(defaultLibraryFolder: path);
    await _save();
    notifyListeners();
  }

  /// Set border spacing
  Future<void> setBorderSpacing(double spacing) async {
    _settings = _settings.copyWith(borderSpacing: spacing);
    await _save();
    notifyListeners();
  }

  /// Load settings from storage
  void reload() {
    _settings = _storageService.loadSettings();
    notifyListeners();
  }

  Future<void> _save() async {
    await _storageService.saveSettings(_settings);
  }
}