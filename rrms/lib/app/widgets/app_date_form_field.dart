import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:rrms/_all.dart';

class AppDateFormField extends StatelessWidget {
  final String? label;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime? date)? onChanged;
  final String? Function(DateTime? date)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? color;
  final Color? borderColor;
  final DatePickerMode initialDatePickerMode;

  const AppDateFormField({
    super.key,
    this.label,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.color,
    this.borderColor,
    this.initialDatePickerMode = DatePickerMode.day,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdownButton(
      label: label ?? translations.date,
      title: initialValue?.format(),
      errorMessage: autovalidateMode == AutovalidateMode.disabled ? null : validator?.call(initialValue),
      color: color,
      borderColor: borderColor,
      prefix: Icon(Icons.date_range, color: context.secondaryTextStyle.color),
      onTap: () async {
        BottomPicker.date(
          pickerTitle: const SizedBox(),
          dateOrder: DatePickerDateOrder.dmy,
          initialDateTime: initialValue ?? DateTime(1996, 10, 22),
          minDateTime: firstDate ?? DateTime(1940),
          maxDateTime: lastDate ?? DateTime(2050),
          pickerTextStyle: context.textStyle.t16500,
          onChange: (dateTime) => onChanged?.call(dateTime),
          displaySubmitButton: false,
          dismissable: true,
          displayCloseIcon: false,
          height: context.screenHeight * 0.4,
          backgroundColor: context.theme.bottomSheetTheme.backgroundColor ?? Colors.white,
        ).show(context);
      },
    );
  }
}
