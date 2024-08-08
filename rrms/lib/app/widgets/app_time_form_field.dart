import 'package:rrms/_all.dart';

class AppTimeFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TimeOfDay? initialValue;
  final void Function(TimeOfDay? date)? onChanged;
  final String? Function(TimeOfDay? date)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? color;
  final Color? borderColor;

  const AppTimeFormField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotNullOrEmpty) ...{
          Text(label.value, style: context.textStyle.t16400),
          const Gap(10),
        },
        AppDropdownButton(
          title: initialValue?.format(context) ?? hint ?? translations.time,
          errorMessage: autovalidateMode == AutovalidateMode.disabled ? null : validator?.call(initialValue),
          color: color,
          borderColor: borderColor,
          prefix: Icon(Icons.calendar_month_outlined, color: context.secondaryTextStyle.color),
          onTap: () async {
            final dateTime = await showTimePicker(
              initialEntryMode: TimePickerEntryMode.dial,
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (dateTime != null) {
              onChanged?.call(dateTime);
            }
          },
        ),
      ],
    );
  }
}
