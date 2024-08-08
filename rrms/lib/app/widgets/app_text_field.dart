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
  final bool showSufixIcon;

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
    this.showSufixIcon = false,
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
          TextField(
            controller: controller,
            onChanged: (value) => widget.onChanged?.call(value),
            style: context.textStyle.t14500,
            decoration: InputDecoration(
              hintText: widget.label ?? widget.hint ?? '',
              prefixIcon: widget.prefixIcon,
              fillColor: context.theme.inputDecorationTheme.fillColor,
              suffixIcon: () {
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
              focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
              errorBorder: context.theme.inputDecorationTheme.errorBorder,
              focusedErrorBorder: context.theme.inputDecorationTheme.focusedErrorBorder,
              disabledBorder: context.theme.inputDecorationTheme.disabledBorder,
              enabledBorder: context.theme.inputDecorationTheme.enabledBorder,
              border: context.theme.inputDecorationTheme.border,
            ),
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter ?? '•',
          ),
        ],
      ),
    );
  }
}
