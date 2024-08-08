import 'package:rrms/_all.dart';

class AppPasswordTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final void Function(String? text)? onChanged;
  final String? Function(String? text)? validator;
  final String? obscuringCharacter;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final bool showSufixIcon;

  const AppPasswordTextFormField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.margin = EdgeInsets.zero,
    this.obscuringCharacter,
    this.prefixIcon,
    this.showSufixIcon = false,
  });

  @override
  State<AppPasswordTextFormField> createState() => _AppPasswordTextFormFieldState();
}

class _AppPasswordTextFormFieldState extends State<AppPasswordTextFormField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: widget.label,
      hint: widget.hint,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      validator: widget.validator,
      margin: widget.margin,
      obscuringCharacter: widget.obscuringCharacter,
      prefixIcon: widget.prefixIcon,
      obscureText: !visible,
      suffixIcon: () {
        return InkWell(
          onTap: () => setState(() => visible = !visible),
          child: Icon(
            visible ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            size: 20,
            color: context.secondaryTextStyle.color,
          ),
        );
      }(),
    );
  }
}
