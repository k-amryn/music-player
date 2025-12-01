import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/library_folder.dart';
import '../../core/models/track.dart';
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

class _LibraryPaneState extends State<LibraryPane> with AutomaticKeepAliveClientMixin {
  String? _currentPath;
  List<LibraryItem> _items = [];
  bool _isLoading = false;
  bool _isGridView = false;
  bool _hasInitialized = false;  // Track if we've loaded initial data
  
  // Search state
  bool _showSearchBar = false;
  bool _viewingSearchResults = false;
  String? _pathBeforeSearch;
  String? _searchResultRootPath;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  
  // Cache for folder contents to avoid re-fetching
  final Map<String?, List<LibraryItem>> _itemsCache = {};  // null key = root

  Offset? _lastPointerPosition;

  @override
  bool get wantKeepAlive => true;  // Keep state when switching tabs

  @override
  void initState() {
    super.initState();
    _isGridView = widget.settings['gridView'] as bool? ?? false;
    _loadInitialPath();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// Get a unique PageStorageKey for the current path
  PageStorageKey<String> get _pageStorageKey {
    return PageStorageKey<String>('library_${widget.tabId}_${_currentPath ?? 'root'}');
  }

  void _loadInitialPath() {
    if (_hasInitialized) return;  // Don't reload if already initialized
    
    final paneSettings = widget.settings;
    
    // Check for saved current path first
    final savedPath = paneSettings['currentPath'] as String?;
    if (savedPath != null) {
      _navigateTo(savedPath, isInitial: true);
      return;
    }

    // Check for pane-specific default folder
    final defaultFolder = paneSettings['defaultFolder'] as String?;
    if (defaultFolder != null) {
      _navigateTo(defaultFolder, isInitial: true);
      return;
    }
    
    // Otherwise show library folders list
    _hasInitialized = true;
    setState(() {
      _currentPath = null;
      _items = [];
    });
  }

  Future<void> _navigateTo(String path, {bool isInitial = false}) async {
    // Cancel any pending search
    _debounceTimer?.cancel();

    // If navigating from search results, save state
    if (_viewingSearchResults) {
      setState(() {
        _viewingSearchResults = false;
        _searchResultRootPath = path;
      });
    }

    // Check if we have cached data for this path
    if (_itemsCache.containsKey(path)) {
      setState(() {
        _currentPath = path;
        _items = _itemsCache[path]!;
        _hasInitialized = true;
      });
      
      // Save current path to settings (skip if initial load from settings)
      if (!isInitial && mounted) {
        context.read<PaneProvider>().updateTabSettings(
          widget.paneId,
          widget.tabId,
          {'currentPath': path},
        );
      }
      return;
    }
    
    // Only show loading for initial load, not cached navigation
    if (!_hasInitialized || !isInitial) {
      setState(() => _isLoading = true);
    }
    
    final library = context.read<LibraryProvider>();
    final items = await library.getDirectoryContents(path);
    
    // Cache the items
    _itemsCache[path] = items;
    
    if (mounted) {
      setState(() {
        _currentPath = path;
        _items = items;
        _isLoading = false;
        _hasInitialized = true;
      });
    }

    // Save current path to settings (skip if initial load from settings)
    if (!isInitial && mounted) {
      context.read<PaneProvider>().updateTabSettings(
        widget.paneId,
        widget.tabId,
        {'currentPath': path},
      );
    }
  }

  void _goBack() {
    // If viewing search results, back means cancel search
    if (_viewingSearchResults) {
      _toggleSearchBar();
      return;
    }

    final library = context.read<LibraryProvider>();
    
    // If we are at the path we navigated to from search results, return to search results
    if (library.searchQuery.isNotEmpty && _currentPath == _searchResultRootPath) {
      setState(() {
        _viewingSearchResults = true;
        _searchResultRootPath = null;
      });
      return;
    }

    if (_currentPath == null) return;
    
    final parent = library.getParentPath(_currentPath!);
    final settings = context.read<SettingsProvider>();
    
    // Check if current path is a library root
    bool isLibraryRoot = settings.libraryFolders.any((f) => f == _currentPath);

    if (parent == null || isLibraryRoot || !settings.libraryFolders.any((f) => _currentPath!.startsWith(f))) {
      // Going back to library root
      setState(() {
        _currentPath = null;
        _items = _itemsCache[null] ?? [];
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

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (_showSearchBar) {
        // Starting search
        _pathBeforeSearch = _currentPath;
        _viewingSearchResults = true;
      } else {
        // Cancelling search
        _searchController.clear();
        context.read<LibraryProvider>().clearSearch();
        _viewingSearchResults = false;
        
        if (_pathBeforeSearch != null) {
          _navigateTo(_pathBeforeSearch!);
        } else {
          // Go to root
          setState(() {
            _currentPath = null;
            _items = _itemsCache[null] ?? [];
          });
          // If root items not cached, we might need to reload, but _loadInitialPath handles init.
          // If we are returning to root, we should probably ensure items are loaded.
          if (_items.isEmpty && _itemsCache[null] == null) {
             // Force reload of root
             _loadInitialPath();
             // Wait, _loadInitialPath checks _hasInitialized.
             // Let's just manually trigger a root load if needed.
             // Actually, _itemsCache[null] should be populated if we started from root.
          }
        }
      }
    });
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        if (query.isNotEmpty) {
          // Ensure we are in search results view when query executes
          setState(() {
            if (!_viewingSearchResults) {
               _viewingSearchResults = true;
            }
          });
        }
        // Pass _pathBeforeSearch as the scope if we are searching within a folder
        context.read<LibraryProvider>().searchLibrary(query, searchPath: _pathBeforeSearch);
      }
    });
  }

  void _toggleSelection(String path) {
    context.read<LibraryProvider>().toggleSelection(path);
  }

  void _deselectAll() {
    context.read<LibraryProvider>().deselectAll();
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
      
      List<Track> tracks;
      int startIndex;

      if (_viewingSearchResults) {
        // Playing from search results
        // Convert LibraryItems to Tracks
        tracks = library.searchResults
            .where((i) => !i.isDirectory)
            .map((i) => Track(
                  id: i.path, // Use path as ID for now
                  path: i.path,
                  title: i.name,
                  artist: i.artist ?? 'Unknown Artist',
                  album: i.album ?? 'Unknown Album',
                  duration: i.durationMs != null ? Duration(milliseconds: i.durationMs!) : Duration.zero,
                ))
            .toList();
        startIndex = tracks.indexWhere((t) => t.path == item.path);
      } else {
        // Playing from directory
        tracks = await library.getTracksInDirectory(_currentPath!);
        startIndex = tracks.indexWhere((t) => t.path == item.path);
      }
      
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
    super.build(context);  // Required for AutomaticKeepAliveClientMixin
    
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>();
    final audio = context.watch<AudioProvider>();

    final library = context.watch<LibraryProvider>();
    
    // Determine what to show
    final showSearchResults = _viewingSearchResults && library.searchQuery.isNotEmpty;
    final showBack = _currentPath != null || showSearchResults;

    return PopScope(
      canPop: !showBack,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _goBack();
      },
      child: Column(
        children: [
          // Toolbar
          _buildToolbar(context, theme, showBack, showSearchResults),
          
          // Search Bar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _showSearchBar && _viewingSearchResults ? 50 : 0,
            child: _showSearchBar && _viewingSearchResults ? _buildSearchBar(context, theme) : null,
          ),
          
          // Content
          Expanded(
            child: showSearchResults
                ? _buildSearchResults(context, library, audio, theme)
                : _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _currentPath == null
                        ? _buildLibraryRoot(context, settings, theme)
                        : _buildDirectoryView(context, audio, theme),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context, ThemeData theme, bool showBack, bool showSearchResults) {
    final library = context.watch<LibraryProvider>();
    final isSelectionMode = library.isSelectionMode;
    final selectedCount = library.selectedPaths.length;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingSm),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: theme.scaffoldBackgroundColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (isSelectionMode) ...[
            // Selection mode toolbar
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '$selectedCount items selected',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              onPressed: _deselectAll,
              icon: const Icon(Icons.close_rounded),
              iconSize: 20,
              tooltip: 'Clear selection',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ] else ...[
            // Normal toolbar
            // Back button
            if (showBack)
              IconButton(
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back_rounded),
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
                  showSearchResults
                      ? 'Search results'
                      : _currentPath != null
                          ? context.read<LibraryProvider>().getFileName(_currentPath!)
                          : 'Library',
                  style: theme.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            
            // Search toggle
            IconButton(
              onPressed: _toggleSearchBar,
              icon: const Icon(Icons.search_rounded),
              iconSize: 20,
              tooltip: 'Search',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),

            // View toggle
            IconButton(
              onPressed: _toggleViewMode,
              icon: Icon(_isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded),
              iconSize: 20,
              tooltip: _isGridView ? 'List view' : 'Grid view',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMd, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: theme.scaffoldBackgroundColor,
            width: 1,
          ),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search library...',
          prefixIcon: const Icon(Icons.search_rounded, size: 20),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close_rounded, size: 20),
            onPressed: _toggleSearchBar,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    LibraryProvider library,
    AudioProvider audio,
    ThemeData theme,
  ) {
    debugPrint('Building search results. Loading: ${library.isSearching}, Count: ${library.searchResults.length}');
    if (library.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    final results = library.searchResults;
    if (results.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    // Separate folders and tracks
    final folders = results.where((i) => i.isDirectory).toList();
    final tracks = results.where((i) => !i.isDirectory).toList();

    if (_isGridView && folders.isNotEmpty) {
      return CustomScrollView(
        key: const PageStorageKey('search_results_grid'),
        slivers: [
          // Folders in grid
          SliverPadding(
            padding: const EdgeInsets.all(AppDimensions.spacingXs),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildGridFolder(context, folders[index], theme);
                },
                childCount: folders.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                childAspectRatio: 1,
                crossAxisSpacing: AppDimensions.spacingXs,
                mainAxisSpacing: AppDimensions.spacingSm,
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

    return ListView.builder(
      key: const PageStorageKey('search_results_list'),
      itemCount: results.length + (folders.isNotEmpty && tracks.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        // Insert divider between folders and tracks
        if (folders.isNotEmpty && tracks.isNotEmpty && index == folders.length) {
          return const Divider(height: 1);
        }
        
        final adjustedIndex = folders.isNotEmpty && tracks.isNotEmpty && index > folders.length
            ? index - 1
            : index;
        
        final item = results[adjustedIndex];
        
        if (item.isDirectory) {
          return _buildListFolder(context, item, theme);
        } else {
          return _buildTrackItem(context, item, audio, theme);
        }
      },
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
              Icons.folder_open_rounded,
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
        key: _pageStorageKey,
        padding: const EdgeInsets.all(AppDimensions.spacingXs),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 1,
          crossAxisSpacing: AppDimensions.spacingXs,
          mainAxisSpacing: AppDimensions.spacingSm,
        ),
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return _buildGridFolder(context, folder, theme);
        },
      );
    }

    return ListView.builder(
      key: _pageStorageKey,
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
              Icons.folder_open_rounded,
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
        key: _pageStorageKey,
        slivers: [
          // Folders in grid
          SliverPadding(
            padding: const EdgeInsets.all(AppDimensions.spacingXs),
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
                crossAxisSpacing: AppDimensions.spacingXs,
                mainAxisSpacing: AppDimensions.spacingSm,
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
      key: _pageStorageKey,
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
          return _buildListFolder(context, item, theme);
        } else {
          return _buildTrackItem(context, item, audio, theme);
        }
      },
    );
  }

  Widget _buildGridFolder(BuildContext context, dynamic itemOrPath, ThemeData theme) {
    final LibraryItem item;
    if (itemOrPath is LibraryItem) {
      item = itemOrPath;
    } else {
      // Fallback for legacy calls (e.g. from root view)
      final path = itemOrPath is LibraryFolder ? itemOrPath.path : itemOrPath as String;
      final name = itemOrPath is LibraryFolder ? itemOrPath.name : context.read<LibraryProvider>().getFileName(path);
      
      // Try to find the item in _items to get cover art
      item = _items.firstWhere(
        (i) => i.path == path,
        orElse: () => LibraryItem(path: path, name: name, isDirectory: true),
      );
    }

    final library = context.watch<LibraryProvider>();
    final isSelected = library.isSelected(item.path);
    final isSelectionMode = library.isSelectionMode;

    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.2)
          : Colors.transparent,
      child: Listener(
        onPointerDown: (event) => _lastPointerPosition = event.position,
        child: InkWell(
          onTap: () {
            if (isSelectionMode) {
              _toggleSelection(item.path);
            } else {
              _navigateTo(item.path);
            }
          },
          onSecondaryTapUp: (details) {
            if (!isSelected) {
              _toggleSelection(item.path);
            }
            _showFolderContextMenu(context, item.path, details.globalPosition);
          },
          onLongPress: () {
            if (!isSelected) {
              _toggleSelection(item.path);
            }
            _showFolderContextMenu(context, item.path, _lastPointerPosition);
          },
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          hoverColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _buildCoverArt(item.coverArt, theme, isGrid: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppDimensions.spacingXs, 0, AppDimensions.spacingXs, AppDimensions.spacingXs),
                    child: Text(
                      item.name,
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (isSelectionMode || isSelected)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                      size: 20,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
    ));
    }
  
    Widget _buildListFolder(BuildContext context, dynamic itemOrPath, ThemeData theme) {
    final LibraryItem item;
    if (itemOrPath is LibraryItem) {
      item = itemOrPath;
    } else {
      // Fallback for legacy calls
      final path = itemOrPath is LibraryFolder ? itemOrPath.path : itemOrPath as String;
      final name = itemOrPath is LibraryFolder ? itemOrPath.name : context.read<LibraryProvider>().getFileName(path);
      
      // Try to find the item in _items to get cover art
      item = _items.firstWhere(
        (i) => i.path == path,
        orElse: () => LibraryItem(path: path, name: name, isDirectory: true),
      );
    }

    final library = context.watch<LibraryProvider>();
    final isSelected = library.isSelected(item.path);
    final isSelectionMode = library.isSelectionMode;

    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.2)
          : Colors.transparent,
      child: Listener(
        onPointerDown: (event) => _lastPointerPosition = event.position,
        child: InkWell(
          onTap: () {
            if (isSelectionMode) {
              _toggleSelection(item.path);
            } else {
              _navigateTo(item.path);
            }
          },
          onSecondaryTapUp: (details) {
            if (!isSelected) {
              _toggleSelection(item.path);
            }
            _showFolderContextMenu(context, item.path, details.globalPosition);
          },
          onLongPress: () {
            if (!isSelected) {
              _toggleSelection(item.path);
            }
            _showFolderContextMenu(context, item.path, _lastPointerPosition);
          },
          hoverColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: isSelectionMode
                      ? Center(
                          child: Icon(
                            isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                          ),
                        )
                      : _buildCoverArt(item.coverArt, theme, isGrid: false),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverArt(dynamic coverArt, ThemeData theme, {required bool isGrid}) {
    if (coverArt == null) {
      return _buildFolderPlaceholder(theme, isGrid: isGrid);
    }

    if (coverArt is Uint8List && coverArt.isEmpty) {
      return _buildFolderPlaceholder(theme, isGrid: isGrid);
    }

    if (coverArt is String && coverArt.isEmpty) {
      return _buildFolderPlaceholder(theme, isGrid: isGrid);
    }

    // Use a stateful image builder that falls back to folder placeholder on error
    return _CoverArtImage(
      coverArt: coverArt,
      theme: theme,
      isGrid: isGrid,
      placeholder: _buildFolderPlaceholder(theme, isGrid: isGrid),
    );
  }

  Widget _buildFolderPlaceholder(ThemeData theme, {required bool isGrid}) {
    if (isGrid) {
      return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.folder_rounded,
            size: 48,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
          ),
        ),
      );
    } else {
      return Center(
        child: Icon(
          Icons.folder_rounded,
          size: 24,
          color: theme.colorScheme.primary,
        ),
      );
    }
  }

  Widget _buildTrackItem(
    BuildContext context,
    LibraryItem item,
    AudioProvider audio,
    ThemeData theme,
  ) {
    final isPlaying = audio.currentTrack?.path == item.path;
    final duration = item.formattedDuration;
    final library = context.watch<LibraryProvider>();
    final isSelected = library.isSelected(item.path);
    final isSelectionMode = library.isSelectionMode;
    
    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.2)
          : isPlaying
              ? theme.colorScheme.primaryContainer.withValues(alpha: 0.1)
              : Colors.transparent,
      child: Listener(
        onPointerDown: (event) => _lastPointerPosition = event.position,
        child: InkWell(
          onTap: () {
            if (isSelectionMode) {
              _toggleSelection(item.path);
            } else {
              _playItem(item);
            }
          },
          onSecondaryTapUp: (details) {
            if (!isSelected) {
              _toggleSelection(item.path);
            }
            _showFolderContextMenu(context, item.path, details.globalPosition);
          },
          onLongPress: () {
            if (!isSelected) {
              _toggleSelection(item.path);
            }
            _showFolderContextMenu(context, item.path, _lastPointerPosition);
          },
          hoverColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                if (isSelectionMode)
                  Icon(
                    isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    size: 24,
                  )
                else
                  Icon(
                    isPlaying ? Icons.play_arrow_rounded : Icons.music_note_rounded,
                    color: isPlaying ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                const SizedBox(width: 32), // Match ListTile leading spacing roughly
                Expanded(
                  child: Text(
                    item.name.replaceAll(RegExp(r'\.[^.]+$'), ''),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isPlaying ? theme.colorScheme.primary : null,
                      fontWeight: isPlaying ? FontWeight.w500 : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (duration.isNotEmpty) ...[
                const SizedBox(width: 16),
                Text(
                  duration,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPlaying
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ));
  }

  void _showFolderContextMenu(BuildContext context, String path, Offset? position) {
    final library = context.read<LibraryProvider>();
    final isSelected = library.isSelected(path);

    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final pos = position ?? overlay.localToGlobal(Offset.zero) + const Offset(100, 100);
    
    showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(pos.dx, pos.dy, 0, 0),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'select',
          child: ListTile(
            leading: Icon(
              isSelected
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded
            ),
            title: Text(isSelected ? 'Deselect' : 'Select'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'play',
          child: ListTile(
            leading: Icon(Icons.play_arrow_rounded),
            title: Text('Play All'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'default',
          child: ListTile(
            leading: Icon(Icons.star_rounded),
            title: Text('Set as Default'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'refresh',
          child: ListTile(
            leading: Icon(Icons.refresh_rounded),
            title: Text('Refresh Metadata'),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    ).then((value) {
      if (value == 'select') {
        _toggleSelection(path);
      } else if (value == 'play') {
        _playAllInFolder(path);
      } else if (value == 'default') {
        _setAsDefaultFolder(path);
      } else if (value == 'refresh') {
        context.read<LibraryProvider>().refreshMetadata(path);
      }
    });
  }
}

/// A widget that displays cover art and falls back to a placeholder on error
class _CoverArtImage extends StatefulWidget {
  final dynamic coverArt;
  final ThemeData theme;
  final bool isGrid;
  final Widget placeholder;

  const _CoverArtImage({
    required this.coverArt,
    required this.theme,
    required this.isGrid,
    required this.placeholder,
  });

  @override
  State<_CoverArtImage> createState() => _CoverArtImageState();
}

class _CoverArtImageState extends State<_CoverArtImage> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.placeholder;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 1,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    final art = widget.coverArt;
    
    if (art is Uint8List) {
      if (art.isEmpty) return widget.placeholder;
      return Image.memory(
        art,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _hasError = true);
          });
          return widget.placeholder;
        },
      );
    } else if (art is String) {
      if (art.isEmpty) return widget.placeholder;
      return Image.file(
        File(art),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _hasError = true);
          });
          return widget.placeholder;
        },
      );
    }
    return widget.placeholder;
  }
}