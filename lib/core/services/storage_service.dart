import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

/// Service for persisting app data
class StorageService {
  static const String _settingsKey = 'app_settings';
  static const String _layoutKey = 'pane_layout';
  
  late SharedPreferences _prefs;
  
  /// Initialize the storage service
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save app settings
  Future<void> saveSettings(AppSettings settings) async {
    final json = jsonEncode(settings.toJson());
    await _prefs.setString(_settingsKey, json);
  }

  /// Load app settings
  AppSettings loadSettings() {
    final json = _prefs.getString(_settingsKey);
    if (json == null) {
      return const AppSettings();
    }
    try {
      return AppSettings.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      return const AppSettings();
    }
  }

  /// Save pane layout
  Future<void> saveLayout(PaneLayout layout) async {
    final json = jsonEncode(layout.toJson());
    await _prefs.setString(_layoutKey, json);
  }

  /// Load pane layout
  PaneLayout loadLayout() {
    final json = _prefs.getString(_layoutKey);
    if (json == null) {
      return PaneLayout.defaultLayout();
    }
    try {
      return PaneLayout.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      return PaneLayout.defaultLayout();
    }
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}