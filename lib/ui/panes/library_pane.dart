import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/library_folder.dart';
import '../../core/providers/audio_provider.dart';
import '../../core/providers/library_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';

/// Library pane for browsing music files
class LibraryPane extends StatefulWidget {
  final String paneId;
  final String tabId;
  final Map<String, dynamic> settings;

  const LibraryPane({
    super.key,
    required this.paneId,
    required this.tabId,
    this.settings = const {},
  });

  @override
  State<LibraryPane> createState() => _LibraryPaneState();
}

class _LibraryPaneState extends State<LibraryPane> {
  String? _currentPath;
  List<LibraryItem> _items = [];
  bool _isLoading = false;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _isGridView = widget.settings['gridView'] as bool? ?? false;
    _loadInitialPath();
  }

  void _loadInitialPath() {
    final paneSettings = widget.settings;
    
    // Check for saved current path first
    final savedPath = paneSettings['currentPath'] as String?;
    if (savedPath != null) {
      _navigateTo(savedPath);
      return;
    }

    // Check for pane-specific default folder
    final defaultFolder = paneSettings['defaultFolder'] as String?;
    if (defaultFolder != null) {
      _navigateTo(defaultFolder);
      return;
    }
    
    // Otherwise show library folders list
    setState(() {
      _currentPath = null;
      _items = [];
    });
  }

  Future<void> _navigateTo(String path) async {
    setState(() => _isLoading = true);
    
    final library = context.read<LibraryProvider>();
    final items = await library.getDirectoryContents(path);
    
    setState(() {
      _currentPath = path;
      _items = items;
      _isLoading = false;
    });

    // Save current path to settings
    if (mounted) {
      context.read<PaneProvider>().updateTabSettings(
        widget.paneId,
        widget.tabId,
        {'currentPath': path},
      );
    }
  }

  void _goBack() {
    if (_currentPath == null) return;
    
    final library = context.read<LibraryProvider>();
    final parent = library.getParentPath(_currentPath!);
    
    final settings = context.read<SettingsProvider>();
    if (parent == null || !settings.libraryFolders.any((f) => _currentPath!.startsWith(f))) {
      // Go back to library root
      setState(() {
        _currentPath = null;
        _items = [];
      });
      
      // Clear saved path in settings
      if (mounted) {
        context.read<PaneProvider>().updateTabSettings(
          widget.paneId,
          widget.tabId,
          {'currentPath': null},
        );
      }
    } else {
      _navigateTo(parent);
    }
  }

  void _toggleViewMode() {
    setState(() {
      _isGridView = !_isGridView;
    });
    
    // Save to pane settings
    final paneProvider = context.read<PaneProvider>();
    paneProvider.updateTabSettings(
      widget.paneId,
      widget.tabId,
      {'gridView': _isGridView},
    );
  }

  void _setAsDefaultFolder(String path) {
    final paneProvider = context.read<PaneProvider>();
    paneProvider.updateTabSettings(
      widget.paneId,
      widget.tabId,
      {'defaultFolder': path},
    );
  }

  Future<void> _playItem(LibraryItem item) async {
    if (item.isDirectory) {
      _navigateTo(item.path);
    } else {
      final audio = context.read<AudioProvider>();
      final library = context.read<LibraryProvider>();
      
      // Get all tracks in current directory and play from this one
      final tracks = await library.getTracksInDirectory(_currentPath!);
      final startIndex = tracks.indexWhere((t) => t.path == item.path);
      
      if (startIndex >= 0) {
        await audio.playTracks(tracks, startIndex: startIndex);
      }
    }
  }

  Future<void> _playAllInFolder(String path) async {
    final audio = context.read<AudioProvider>();
    final library = context.read<LibraryProvider>();
    
    final tracks = await library.getAllTracksInDirectory(path);
    if (tracks.isNotEmpty) {
      await audio.playTracks(tracks);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>();
    final audio = context.watch<AudioProvider>();

    return Column(
      children: [
        // Toolbar
        _buildToolbar(context, theme),
        
        // Content
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _currentPath == null
                  ? _buildLibraryRoot(context, settings, theme)
                  : _buildDirectoryView(context, audio, theme),
        ),
      ],
    );
  }

  Widget _buildToolbar(BuildContext context, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final toolbarColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingSm),
      color: toolbarColor,
      child: Row(
        children: [
          // Back button
          if (_currentPath != null)
            IconButton(
              onPressed: _goBack,
              icon: const Icon(Icons.arrow_back),
              iconSize: 20,
              tooltip: 'Go back',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          
          // Path breadcrumb
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _currentPath != null
                    ? context.read<LibraryProvider>().getFileName(_currentPath!)
                    : 'Library',
                style: theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          
          // View toggle
          IconButton(
            onPressed: _toggleViewMode,
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            iconSize: 20,
            tooltip: _isGridView ? 'List view' : 'Grid view',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildLibraryRoot(
    BuildContext context,
    SettingsProvider settings,
    ThemeData theme,
  ) {
    final folders = settings.libraryFolders;
    
    if (folders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              'No library folders configured',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Add folders in Settings',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    if (_isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 1,
          crossAxisSpacing: AppDimensions.spacingMd,
          mainAxisSpacing: AppDimensions.spacingMd,
        ),
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return _buildGridFolder(context, folder, theme);
        },
      );
    }

    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (context, index) {
        final folder = folders[index];
        return _buildListFolder(context, folder, theme);
      },
    );
  }

  Widget _buildDirectoryView(
    BuildContext context,
    AudioProvider audio,
    ThemeData theme,
  ) {
    if (_items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              'Folder is empty',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // Separate folders and tracks
    final folders = _items.where((i) => i.isDirectory).toList();
    final tracks = _items.where((i) => !i.isDirectory).toList();

    if (_isGridView && folders.isNotEmpty) {
      return CustomScrollView(
        slivers: [
          // Folders in grid
          SliverPadding(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildGridFolder(context, folders[index].path, theme);
                },
                childCount: folders.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                childAspectRatio: 1,
                crossAxisSpacing: AppDimensions.spacingMd,
                mainAxisSpacing: AppDimensions.spacingMd,
              ),
            ),
          ),
          
          // Divider
          if (tracks.isNotEmpty)
            const SliverToBoxAdapter(
              child: Divider(height: 1),
            ),
          
          // Tracks in list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildTrackItem(context, tracks[index], audio, theme);
              },
              childCount: tracks.length,
            ),
          ),
        ],
      );
    }

    // List view for everything
    return ListView.builder(
      itemCount: _items.length + (folders.isNotEmpty && tracks.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        // Insert divider between folders and tracks
        if (folders.isNotEmpty && tracks.isNotEmpty && index == folders.length) {
          return const Divider(height: 1);
        }
        
        final adjustedIndex = folders.isNotEmpty && tracks.isNotEmpty && index > folders.length
            ? index - 1
            : index;
        
        final item = _items[adjustedIndex];
        
        if (item.isDirectory) {
          return _buildListFolder(context, item.path, theme);
        } else {
          return _buildTrackItem(context, item, audio, theme);
        }
      },
    );
  }

  Widget _buildGridFolder(BuildContext context, String path, ThemeData theme) {
    final name = context.read<LibraryProvider>().getFileName(path);
    final isDark = theme.brightness == Brightness.dark;
    final folderBgColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.04);
    
    return GestureDetector(
      onTap: () => _navigateTo(path),
      onSecondaryTapUp: (details) => _showFolderContextMenu(context, path, details.globalPosition),
      onLongPress: () => _showFolderContextMenu(context, path, null),
      child: Container(
        color: folderBgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingSm),
              child: Text(
                name,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListFolder(BuildContext context, String path, ThemeData theme) {
    final name = context.read<LibraryProvider>().getFileName(path);
    
    return ListTile(
      leading: Icon(
        Icons.folder,
        color: theme.colorScheme.primary,
      ),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => _navigateTo(path),
      onLongPress: () => _showFolderContextMenu(context, path, null),
    );
  }

  Widget _buildTrackItem(
    BuildContext context,
    LibraryItem item,
    AudioProvider audio,
    ThemeData theme,
  ) {
    final isPlaying = audio.currentTrack?.path == item.path;
    
    return ListTile(
      leading: Icon(
        isPlaying ? Icons.play_arrow : Icons.music_note,
        color: isPlaying ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        item.name.replaceAll(RegExp(r'\.[^.]+$'), ''),
        style: TextStyle(
          color: isPlaying ? theme.colorScheme.primary : null,
          fontWeight: isPlaying ? FontWeight.w500 : null,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => _playItem(item),
      selected: isPlaying,
    );
  }

  void _showFolderContextMenu(BuildContext context, String path, Offset? position) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final pos = position ?? overlay.localToGlobal(Offset.zero) + const Offset(100, 100);
    
    showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(pos.dx, pos.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'play',
          child: ListTile(
            leading: Icon(Icons.play_arrow),
            title: Text('Play All'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'default',
          child: ListTile(
            leading: Icon(Icons.star),
            title: Text('Set as Default'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    ).then((value) {
      if (value == 'play') {
        _playAllInFolder(path);
      } else if (value == 'default') {
        _setAsDefaultFolder(path);
      }
    });
  }
}