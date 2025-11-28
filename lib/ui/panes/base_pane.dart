import 'package:flutter/material.dart';

/// Base content wrapper for all panes
class BasePaneContent extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const BasePaneContent({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// Abstract base class for pane implementations
abstract class BasePaneState<T extends StatefulWidget> extends State<T> {
  /// Override to provide pane-specific settings
  Map<String, dynamic> get defaultSettings => {};

  /// Override to build the pane content
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }
}