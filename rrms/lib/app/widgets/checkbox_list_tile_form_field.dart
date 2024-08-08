import 'package:rrms/_all.dart';

class CheckboxListTileFormField extends FormField<bool> {
  CheckboxListTileFormField({
    super.key,
    super.validator,
    Widget? title,
    FormFieldSetter<bool>? onChanged,
    bool value = false,
    bool autovalidate = false,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
  }) : super(
          initialValue: value,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              value: value,
              onChanged: onChanged,
              controlAffinity: controlAffinity,
              title: title,
              subtitle: state.hasError
                  ? Builder(
                      builder: (context) => Text(
                        state.errorText ?? '',
                        style: TextStyle(color: context.theme.colorScheme.error),
                      ),
                    )
                  : null,
            );
          },
        );
}
