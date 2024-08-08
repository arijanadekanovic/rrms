import 'package:rrms/_all.dart';

class AppRadio extends StatelessWidget {
  final String? title;
  final bool isSelected;
  final void Function()? onTap;

  const AppRadio({
    super.key,
    this.title,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: isSelected ? 1 : 0,
            groupValue: 1,
            onChanged: (_) {},
          ),
          Text(
            title.value,
            style: context.textStyle.t14500.withColor(
              isSelected ? context.accentTextStyle.color : context.textStyle.color,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
