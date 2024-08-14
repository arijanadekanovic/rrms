import 'package:rrms/_all.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final void Function(String? text)? onChanged;
  final String? Function(String? text)? validator;
  final bool obscureText;
  final String? obscuringCharacter;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool showSufixIcon;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? height;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.margin = const EdgeInsets.only(bottom: 20),
    this.obscuringCharacter,
    this.prefixIcon,
    this.sufixIcon,
    this.showSufixIcon = false,
    this.borderRadius,
    this.borderColor,
    this.height,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller.text = widget.initialValue.value;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputBorder? maybeWithBorderRadius(InputBorder? inputBorder) {
      if (widget.borderRadius != null) {
        return OutlineInputBorder(
          borderRadius: widget.borderRadius!,
          borderSide: inputBorder?.borderSide.copyWith(color: widget.borderColor) ?? BorderSide(color: widget.borderColor ?? context.theme.inputDecorationTheme.border!.borderSide.color),
        );
      }

      return inputBorder?.copyWith(borderSide: inputBorder.borderSide.copyWith(color: widget.borderColor));
    }

    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label.isNotNullOrEmpty) ...{
            Text(widget.label.value, style: context.textStyle.t14500),
            const Gap(10),
          },
          SizedBox(
            height: widget.height,
            child: TextField(
              controller: controller,
              onChanged: (value) => widget.onChanged?.call(value),
              style: context.textStyle.t14500,
              decoration: InputDecoration(
                hintText: widget.label ?? widget.hint ?? '',
                prefixIcon: widget.prefixIcon,
                fillColor: context.theme.inputDecorationTheme.fillColor,
                suffixIcon: () {
                  if (widget.sufixIcon != null) {
                    return widget.sufixIcon;
                  }

                  final isEmpty = controller.text.isNullOrEmpty;

                  if (isEmpty || !widget.showSufixIcon) {
                    return null;
                  }

                  return InkWell(
                    onTap: () {
                      controller.clear();
                      setState(() => widget.onChanged?.call(''));
                    },
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: context.secondaryTextStyle.color,
                    ),
                  );
                }(),
                focusedBorder: maybeWithBorderRadius(context.theme.inputDecorationTheme.focusedBorder),
                errorBorder: maybeWithBorderRadius(context.theme.inputDecorationTheme.errorBorder),
                focusedErrorBorder: maybeWithBorderRadius(context.theme.inputDecorationTheme.focusedErrorBorder),
                disabledBorder: maybeWithBorderRadius(context.theme.inputDecorationTheme.disabledBorder),
                enabledBorder: maybeWithBorderRadius(context.theme.inputDecorationTheme.enabledBorder),
                border: maybeWithBorderRadius(context.theme.inputDecorationTheme.border),
              ),
              obscureText: widget.obscureText,
              obscuringCharacter: widget.obscuringCharacter ?? '•',
            ),
          ),
        ],
      ),
    );
  }
}
