import 'package:rrms/_all.dart';

class AppTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final void Function(String? text)? onChanged;
  final void Function()? onReset;
  final String? Function(String? text)? validator;
  final bool obscureText;
  final String? obscuringCharacter;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final bool showResetIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final Widget? suffixIcon;
  final int minLines;
  final int maxLines;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const AppTextFormField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.onReset,
    this.validator,
    this.obscureText = false,
    this.margin = EdgeInsets.zero,
    this.obscuringCharacter,
    this.prefixIcon,
    this.showResetIcon = false,
    this.enabledBorder,
    this.focusedBorder,
    this.border,
    this.suffixIcon,
    this.minLines = 1,
    this.maxLines = 1,
    this.focusNode,
    this.controller,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final _textEditingController = TextEditingController();

  TextEditingController get controller => widget.controller ?? _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController.text = widget.initialValue.value;
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        minLines: widget.minLines,
        focusNode: widget.focusNode,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        controller: controller,
        onChanged: (value) => widget.onChanged?.call(value),
        style: context.textStyle.t14500,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: context.secondaryTextStyle.t14500.copyWith(overflow: TextOverflow.ellipsis),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.label,
          labelStyle: context.secondaryTextStyle.t14500.copyWith(overflow: TextOverflow.ellipsis),
          contentPadding: EdgeInsets.all(10),
          fillColor: context.theme.inputDecorationTheme.fillColor,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon ??
              () {
                final isEmpty = (controller.text).isNullOrEmpty;

                if (isEmpty || !widget.showResetIcon) {
                  return null;
                }

                return InkWell(
                  onTap: () {
                    controller.clear();
                    context.unfocus();

                    if (widget.onReset != null) {
                      widget.onReset?.call();
                    } else {
                      widget.onChanged?.call('');
                    }
                  },
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: context.secondaryTextStyle.color,
                  ),
                );
              }(),
          focusedBorder: widget.focusedBorder ?? context.theme.inputDecorationTheme.focusedBorder,
          errorBorder: context.theme.inputDecorationTheme.errorBorder,
          focusedErrorBorder: context.theme.inputDecorationTheme.focusedErrorBorder,
          disabledBorder: context.theme.inputDecorationTheme.disabledBorder,
          enabledBorder: widget.enabledBorder ?? context.theme.inputDecorationTheme.enabledBorder,
          border: widget.border ?? context.theme.inputDecorationTheme.border,
        ),
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter ?? '•',
      ),
    );
  }
}
