import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/audio_provider.dart';
import 'core/providers/settings_provider.dart';
import 'core/providers/pane_provider.dart';
import 'core/providers/library_provider.dart';
import 'core/services/audio_service.dart';
import 'core/services/storage_service.dart';
import 'theme/app_theme.dart';
import 'ui/screens/home_screen.dart';

/// Main app widget
class FoobarFlutterApp extends StatelessWidget {
  final StorageService storageService;

  const FoobarFlutterApp({
    super.key,
    required this.storageService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<StorageService>.value(value: storageService),
        Provider<AudioService>(
          create: (_) => AudioService(),
          dispose: (_, service) => service.dispose(),
        ),
        
        // Providers
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider<PaneProvider>(
          create: (context) => PaneProvider(
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider<AudioProvider>(
          create: (context) => AudioProvider(
            context.read<AudioService>(),
          ),
        ),
        ChangeNotifierProvider<LibraryProvider>(
          create: (_) => LibraryProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'Foobar Flutter',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(settings.themeColor),
            darkTheme: AppTheme.darkTheme(settings.themeColor),
            themeMode: settings.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}