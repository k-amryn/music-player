import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/pane.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';
import 'pane_widget.dart';
import 'resizable_divider.dart';
import '../../core/providers/settings_provider.dart';

/// Container that renders the entire pane tree
class PaneContainer extends StatelessWidget {
  const PaneContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaneProvider>(
      builder: (context, paneProvider, child) {
        // On mobile, we want to force a single pane view initially, but the user requested
        // to remove the forced structure. So we just render the root node as is.
        // If we wanted to force single pane on mobile, we would check Platform.isAndroid/iOS
        // and render just the active pane. But per instructions, we revert to standard behavior.
        
        return _buildPaneNode(
          context,
          paneProvider.layout.root,
          paneProvider.layout.editMode,
          [],
        );
      },
    );
  }

  Widget _buildPaneNode(
    BuildContext context,
    PaneNode node,
    bool editMode,
    List<int> path,
  ) {
    if (node is PaneLeaf) {
      return PaneWidget(
        pane: node.pane,
        editMode: editMode,
      );
    } else if (node is PaneSplit) {
      return _PaneSplitWidget(
        split: node,
        editMode: editMode,
        path: path,
        buildChild: (childNode, childPath) =>
            _buildPaneNode(context, childNode, editMode, childPath),
      );
    }
    return const SizedBox.shrink();
  }
}

class _PaneSplitWidget extends StatefulWidget {
  final PaneSplit split;
  final bool editMode;
  final List<int> path;
  final Widget Function(PaneNode node, List<int> path) buildChild;

  const _PaneSplitWidget({
    required this.split,
    required this.editMode,
    required this.path,
    required this.buildChild,
  });

  @override
  State<_PaneSplitWidget> createState() => _PaneSplitWidgetState();
}

class _PaneSplitWidgetState extends State<_PaneSplitWidget> {
  late double _ratio;
  double? _totalSize;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _ratio = widget.split.ratio;
  }

  @override
  void didUpdateWidget(covariant _PaneSplitWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.split.ratio != widget.split.ratio && !_isDragging) {
      _ratio = widget.split.ratio;
    }
  }

  void _handleDrag(double delta) {
    if (_totalSize == null) return;

    final newRatio = _ratio + delta / _totalSize!;
    setState(() {
      _ratio = newRatio.clamp(0.1, 0.9);
    });
  }

  void _handleDragEnd() {
    _isDragging = false;
    final paneProvider = context.read<PaneProvider>();
    paneProvider.updateSplitRatio(widget.path, _ratio);
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.split.direction == SplitDirection.horizontal;

    final settings = context.watch<SettingsProvider>();
    // Ensure minimum spacing of 1px as requested
    final spacing = settings.borderSpacing < 1.0 ? 1.0 : settings.borderSpacing;
    final handleSize = AppDimensions.paneDividerSize;
    final hitAreaSize = spacing > handleSize ? spacing : handleSize;

    return LayoutBuilder(
      builder: (context, constraints) {
        _totalSize = isHorizontal ? constraints.maxWidth : constraints.maxHeight;
        final totalSize = _totalSize!;
        
        final splitPos = totalSize * _ratio;
        final halfSpacing = spacing / 2;
        
        // Calculate sizes for panes
        final size1 = splitPos - halfSpacing;
        final size2 = totalSize - splitPos - halfSpacing;

        // Ensure panes don't have negative size
        final validSize1 = size1 < 0 ? 0.0 : size1;
        final validSize2 = size2 < 0 ? 0.0 : size2;

        return Stack(
          children: [
            // First Pane
            Positioned(
              left: isHorizontal ? 0 : 0,
              top: isHorizontal ? 0 : 0,
              width: isHorizontal ? validSize1 : constraints.maxWidth,
              height: isHorizontal ? constraints.maxHeight : validSize1,
              child: widget.buildChild(widget.split.first, [...widget.path, 0]),
            ),
            
            // Second Pane
            Positioned(
              left: isHorizontal ? splitPos + halfSpacing : 0,
              top: isHorizontal ? 0 : splitPos + halfSpacing,
              width: isHorizontal ? validSize2 : constraints.maxWidth,
              height: isHorizontal ? constraints.maxHeight : validSize2,
              child: widget.buildChild(widget.split.second, [...widget.path, 1]),
            ),

            // Divider Handle (Centered on splitPos)
            Positioned(
              left: isHorizontal ? splitPos - hitAreaSize / 2 : 0,
              top: isHorizontal ? 0 : splitPos - hitAreaSize / 2,
              width: isHorizontal ? hitAreaSize : constraints.maxWidth,
              height: isHorizontal ? constraints.maxHeight : hitAreaSize,
              child: ResizableDivider(
                isHorizontal: isHorizontal,
                onDrag: _handleDrag,
                onDragStart: () => _isDragging = true,
                onDragEnd: _handleDragEnd,
              ),
            ),
          ],
        );
      },
    );
  }
}