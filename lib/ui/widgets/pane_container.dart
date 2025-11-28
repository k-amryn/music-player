import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/pane.dart';
import '../../core/providers/pane_provider.dart';
import '../../theme/app_theme.dart';
import 'pane_widget.dart';
import 'resizable_divider.dart';

/// Container that renders the entire pane tree
class PaneContainer extends StatelessWidget {
  const PaneContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaneProvider>(
      builder: (context, paneProvider, child) {
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

    return LayoutBuilder(
      builder: (context, constraints) {
        _totalSize = isHorizontal ? constraints.maxWidth : constraints.maxHeight;
        
        // Use flex to avoid pixel overflow issues
        final flex1 = (_ratio * 10000).round();
        final flex2 = 10000 - flex1;

        if (isHorizontal) {
          return Row(
            children: [
              Expanded(
                flex: flex1,
                child: widget.buildChild(widget.split.first, [...widget.path, 0]),
              ),
              ResizableDivider(
                isHorizontal: true,
                onDrag: _handleDrag,
                onDragStart: () => _isDragging = true,
                onDragEnd: _handleDragEnd,
              ),
              Expanded(
                flex: flex2,
                child: widget.buildChild(widget.split.second, [...widget.path, 1]),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Expanded(
                flex: flex1,
                child: widget.buildChild(widget.split.first, [...widget.path, 0]),
              ),
              ResizableDivider(
                isHorizontal: false,
                onDrag: _handleDrag,
                onDragStart: () => _isDragging = true,
                onDragEnd: _handleDragEnd,
              ),
              Expanded(
                flex: flex2,
                child: widget.buildChild(widget.split.second, [...widget.path, 1]),
              ),
            ],
          );
        }
      },
    );
  }
}