import 'package:flutter/material.dart';

/// Shows a popup menu with a fade transition instead of the default expansion.
Future<T?> showFadeMenu<T>({
  required BuildContext context,
  required RelativeRect position,
  required List<PopupMenuEntry<T>> items,
  T? initialValue,
  double? elevation,
  Color? shadowColor,
  Color? surfaceTintColor,
  String? semanticLabel,
  ShapeBorder? shape,
  Color? color,
  bool useRootNavigator = false,
  BoxConstraints? constraints,
  Clip clipBehavior = Clip.none,
}) {
  final NavigatorState navigator = Navigator.of(context, rootNavigator: useRootNavigator);
  return navigator.push(_FadeMenuRoute<T>(
    position: position,
    items: items,
    initialValue: initialValue,
    elevation: elevation,
    shadowColor: shadowColor,
    surfaceTintColor: surfaceTintColor,
    semanticLabel: semanticLabel,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    shape: shape,
    color: color,
    constraints: constraints,
    clipBehavior: clipBehavior,
  ));
}

class _FadeMenuRoute<T> extends PopupRoute<T> {
  final RelativeRect position;
  final List<PopupMenuEntry<T>> items;
  final T? initialValue;
  final double? elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final String? semanticLabel;
  final ShapeBorder? shape;
  final Color? color;
  final BoxConstraints? constraints;
  final Clip clipBehavior;

  _FadeMenuRoute({
    required this.position,
    required this.items,
    this.initialValue,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.semanticLabel,
    required this.barrierLabel,
    this.shape,
    this.color,
    this.constraints,
    this.clipBehavior = Clip.none,
  });

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, 1.0 / 3.0),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _FadeMenuLayoutDelegate(
              position,
              mediaQuery.padding,
            ),
            child: FadeTransition(
              opacity: animation,
              child: Material(
                shape: shape ?? popupMenuTheme.shape ?? theme.popupMenuTheme.shape,
                color: color ?? popupMenuTheme.color ?? theme.popupMenuTheme.color ?? theme.cardColor,
                type: MaterialType.card,
                elevation: elevation ?? popupMenuTheme.elevation ?? theme.popupMenuTheme.elevation ?? 8.0,
                shadowColor: shadowColor ?? popupMenuTheme.shadowColor ?? theme.popupMenuTheme.shadowColor,
                surfaceTintColor: surfaceTintColor ?? popupMenuTheme.surfaceTintColor ?? theme.popupMenuTheme.surfaceTintColor,
                clipBehavior: clipBehavior,
                child: IntrinsicWidth(
                  stepWidth: 56.0,
                  child: Semantics(
                    scopesRoute: true,
                    namesRoute: true,
                    explicitChildNodes: true,
                    label: semanticLabel,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FadeMenuLayoutDelegate extends SingleChildLayoutDelegate {
  final RelativeRect position;
  final EdgeInsets padding;

  _FadeMenuLayoutDelegate(this.position, this.padding);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = position.left;
    double y = position.top;

    // Check horizontal overflow
    if (x + childSize.width > size.width - padding.right) {
      x = size.width - padding.right - childSize.width;
    }
    if (x < padding.left) {
      x = padding.left;
    }

    // Check vertical overflow
    if (y + childSize.height > size.height - padding.bottom) {
      y = size.height - padding.bottom - childSize.height;
    }
    if (y < padding.top) {
      y = padding.top;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_FadeMenuLayoutDelegate oldDelegate) {
    return position != oldDelegate.position || padding != oldDelegate.padding;
  }
}