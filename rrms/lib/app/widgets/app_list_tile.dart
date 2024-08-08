import 'package:rrms/_all.dart';

class AppListTile extends StatelessWidget {
  final Widget? leading;
  final double? leadingGap;
  final String? title;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final TextAlign? titleTextAlign;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? child;
  final Widget? trailing;
  final bool isSelected;
  final void Function()? onTap;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppListTile({
    super.key,
    this.leading,
    this.leadingGap,
    this.title,
    this.titleStyle,
    this.titleColor,
    this.titleTextAlign,
    this.subtitle,
    this.subtitleStyle,
    this.child,
    this.trailing,
    this.isSelected = false,
    this.onTap,
    this.color,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color ?? context.appTheme.surfaceBackgroundColor,
        ),
        child: Row(
          children: [
            if (leading != null) ...{
              leading!,
              if (leadingGap != null) Gap(leadingGap.value),
              if (leadingGap == null) Gap(15),
            },
            Expanded(
              child: child ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.value,
                        style: titleStyle ?? context.textStyle.t16400.withColor(titleColor ?? context.textStyle.color),
                        softWrap: true,
                        textAlign: titleTextAlign,
                      ),
                      if (subtitle.isNotNullOrEmpty)
                        Text(
                          subtitle.value,
                          style: subtitleStyle ?? context.secondaryTextStyle.t12400,
                          softWrap: true,
                        ),
                    ],
                  ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
