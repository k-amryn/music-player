import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// A draggable divider for resizing panes
class ResizableDivider extends StatefulWidget {
  final bool isHorizontal;
  final ValueChanged<double> onDrag;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;

  const ResizableDivider({
    super.key,
    required this.isHorizontal,
    required this.onDrag,
    this.onDragStart,
    this.onDragEnd,
  });

  @override
  State<ResizableDivider> createState() => _ResizableDividerState();
}

class _ResizableDividerState extends State<ResizableDivider> {
  bool _isDragging = false;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = _isDragging || _isHovering;

    return MouseRegion(
      cursor: widget.isHorizontal
          ? SystemMouseCursors.resizeColumn
          : SystemMouseCursors.resizeRow,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (_) {
          setState(() => _isDragging = true);
          widget.onDragStart?.call();
        },
        onPanUpdate: (details) {
          final delta = widget.isHorizontal
              ? details.delta.dx
              : details.delta.dy;
          widget.onDrag(delta);
        },
        onPanEnd: (_) {
          setState(() => _isDragging = false);
          widget.onDragEnd?.call();
        },
        child: Container(
          width: widget.isHorizontal ? AppDimensions.paneDividerSize : null,
          height: widget.isHorizontal ? null : AppDimensions.paneDividerSize,
          color: Colors.transparent,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: widget.isHorizontal ? (isActive ? 3 : 1) : double.infinity,
              height: widget.isHorizontal ? double.infinity : (isActive ? 3 : 1),
              color: isActive
                  ? theme.colorScheme.primary.withValues(alpha: 0.4)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}