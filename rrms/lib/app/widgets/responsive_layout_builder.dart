import 'package:flutter/widgets.dart';

/// Namespace for Default App Breakpoints
abstract class AppBreakpoint {
  /// Max width for a small layout.
  static const double small = 760;

  /// Max width for a medium layout.
  static const double medium = 1300;

  /// Max width for a large layout.
  static const double large = 1920;
}

/// Signature for the individual builders (`small`, `large`, etc.).
typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

/// A wrapper around [LayoutBuilder] which exposes builders for
/// various responsive breakpoints.
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    super.key,
    this.small,
    this.medium,
    this.large,
    this.xLarge,
    this.child,
  });

  /// [ResponsiveLayoutWidgetBuilder] for small layout.
  final ResponsiveLayoutWidgetBuilder? small;

  /// [ResponsiveLayoutWidgetBuilder] for medium layout.
  final ResponsiveLayoutWidgetBuilder? medium;

  /// [ResponsiveLayoutWidgetBuilder] for large layout.
  final ResponsiveLayoutWidgetBuilder? large;

  /// [ResponsiveLayoutWidgetBuilder] for xLarge layout.
  final ResponsiveLayoutWidgetBuilder? xLarge;

  /// Optional child widget which will be passed
  /// to the `small`, `large` and `xLarge`
  /// builders as a way to share/optimize shared layout.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= AppBreakpoint.small) {
          return (small ?? _default).call(context, child);
        }
        if (constraints.maxWidth <= AppBreakpoint.medium) {
          return (medium ?? _default).call(context, child);
        }
        if (constraints.maxWidth <= AppBreakpoint.large) {
          return (large ?? _default).call(context, child);
        }

        return _default.call(context, child);
      },
    );
  }

  ResponsiveLayoutWidgetBuilder get _default => small ?? medium ?? large ?? xLarge ?? (_, __) => Container();
}
