import 'package:rrms/_all.dart';

class ResidenceTypeFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final ResidenceType? initialValue;
  final void Function(ResidenceType? residenceType)? onChanged;
  final String? Function(ResidenceType? residenceType)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? color;
  final Color? borderColor;

  const ResidenceTypeFormField({
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
    return AppDropdownButton(
      label: label,
      hint: hint ?? 'Select residence type',
      title: initialValue?.title,
      color: color,
      borderColor: borderColor,
      onTap: () {
        showAppDialog(
          context,
          AppDialogModel(
            title: 'Residence types',
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: ResidenceType.values.length,
              itemBuilder: (context, index) => AppListTile(
                title: ResidenceType.values[index].title,
                onTap: () {
                  onChanged?.call(ResidenceType.values[index]);
                  context.pop();
                },
              ),
              separatorBuilder: (context, index) => Line.horizontal(),
            ),
          ),
        );
      },
    );
  }
}
