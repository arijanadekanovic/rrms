import 'package:rrms/_all.dart';

class AppDropdownButton extends StatelessWidget {
  final String? title;
  final String? label;
  final Widget? child;
  final String? errorMessage;
  final void Function()? onTap;
  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final double dropdownIconSize;
  final Widget? prefix;

  const AppDropdownButton({
    super.key,
    this.title,
    this.label,
    this.child,
    this.errorMessage,
    this.onTap,
    this.color,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    this.shrinkWrap = false,
    this.dropdownIconSize = 18,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Button(
              shrinkWrap: shrinkWrap,
              padding: padding,
              borderColor: () {
                if (errorMessage.isNotNullOrEmpty) {
                  return context.theme.inputDecorationTheme.errorStyle?.color;
                }

                return borderColor ?? context.theme.dropdownMenuTheme.inputDecorationTheme?.enabledBorder?.borderSide.color;
              }(),
              color: color,
              onTap: onTap,
              child: Row(
                children: [
                  if (prefix != null) ...[
                    prefix!,
                    const Gap(10),
                  ],
                  shrinkWrap
                      ? child ??
                          Text(
                            title ?? label.value,
                            style: title.isNotNullOrEmpty ? context.textStyle.t16400 : context.secondaryTextStyle.t16400,
                          )
                      : Expanded(
                          child: child ??
                              Text(
                                title ?? label.value,
                                style: title.isNotNullOrEmpty ? context.textStyle.t16400 : context.secondaryTextStyle.t16400,
                              ),
                        ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: context.secondaryTextStyle.color,
                    size: dropdownIconSize,
                  ),
                ],
              ),
            ),
            if (label.isNotNullOrEmpty && label != title && title.isNotNullOrEmpty)
              Positioned(
                top: -10,
                left: 6,
                child: Container(
                  padding: EdgeInsets.all(2),
                  color: context.theme.scaffoldBackgroundColor,
                  child: Text(
                    label.value,
                    style: context.secondaryTextStyle.t12500,
                  ),
                ),
              ),
          ],
        ),
        if (errorMessage.isNotNullOrEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
            ),
            child: Text(
              errorMessage.value,
              style: context.textStyle.t12400.withColor(context.theme.inputDecorationTheme.errorStyle?.color ?? Colors.red),
            ),
          ),
      ],
    );
  }
}
