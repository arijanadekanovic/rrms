import 'package:rrms/_all.dart';

class Button extends StatefulWidget {
  final void Function()? onTap;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final bool isLoading;
  final bool isDisabled;
  final Color? color;
  final Color? textColor;
  final Color? loaderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final bool borderDotted;
  final double elevation;
  final Gradient? gradient;

  final bool primary;
  final bool lean;
  final bool secondary;
  final bool transparent;
  final bool rounded;
  final bool shrinkWrap;

  const Button({
    super.key,
    this.onTap,
    this.text,
    this.textStyle,
    this.child,
    this.isLoading = false,
    this.isDisabled = false,
    this.color,
    this.textColor,
    this.loaderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    this.margin = const EdgeInsets.all(0),
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 1.5,
    this.borderDotted = false,
    this.elevation = 0,
    this.gradient,
    this.primary = false,
    this.lean = false,
    this.secondary = false,
    this.transparent = false,
    this.rounded = false,
    this.shrinkWrap = false,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double get _borderRadius => widget.borderRadius ?? (widget.rounded ? 50 : 6);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = () {
      if (widget.gradient != null || widget.transparent) {
        return null;
      }

      if (widget.isDisabled) {
        return context.appTheme.separatorDark;
      }

      if (widget.color != null) {
        return widget.color;
      }

      if (widget.primary) {
        return context.appTheme.accentColor;
      }

      if (widget.secondary) {
        return Colors.transparent;
      }

      return null;
    }();

    final borderColor = () {
      if (widget.borderDotted) {
        return null;
      }

      if (widget.isDisabled) {
        return context.appTheme.separatorDark;
      }

      if (widget.borderColor != null) {
        return widget.borderColor!;
      }

      if (widget.color != null) {
        return widget.color!;
      }

      if (widget.primary || widget.secondary) {
        return context.appTheme.accentColor;
      }
    }();

    final textColor = () {
      if (widget.textColor != null) {
        return widget.textColor!;
      }

      if (widget.primary) {
        return Colors.white;
      }

      if (widget.secondary) {
        return context.appTheme.accentColor;
      }

      return context.textStyle.color;
    }();

    final child = () {
      if (widget.isLoading) {
        return Loader.sm(
          color: widget.loaderColor ?? widget.textColor ?? Colors.white,
          width: 26,
          height: 26,
        );
      }

      if (widget.text != null) {
        return Text(
          widget.text.value,
          style: (widget.textStyle ?? context.textStyle.t18700).withColor(textColor),
          overflow: TextOverflow.ellipsis,
        );
      }

      return widget.child;
    }();

    final button = Clickable(
      onTap: widget.isDisabled ? null : widget.onTap,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        padding: widget.lean ? const EdgeInsets.symmetric(vertical: 5, horizontal: 15) : widget.padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: widget.gradient,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );

    final elevatedButton = PhysicalModel(
      color: backgroundColor ?? Colors.transparent,
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: button,
    );

    if (widget.elevation > 0) {
      if (widget.shrinkWrap) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: widget.margin,
              child: elevatedButton,
            ),
          ],
        );
      }

      return Container(
        margin: widget.margin,
        child: elevatedButton,
      );
    }

    if (widget.shrinkWrap) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: widget.margin,
            child: button,
          ),
        ],
      );
    }

    return Container(
      margin: widget.margin,
      child: button,
    );
  }
}
