import 'package:rrms/_all.dart';

class AppCheckboxListTile extends StatelessWidget {
  final Widget? leading;
  final double? leadingGap;
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const AppCheckboxListTile({
    super.key,
    this.leading,
    this.leadingGap,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.isSelected = false,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: leading,
      leadingGap: leadingGap,
      title: title,
      titleStyle: titleStyle,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      trailing: Checkbox(
        value: isSelected,
        onChanged: (_) {},
      ),
      isSelected: isSelected,
      onTap: onTap,
      padding: padding,
    );
  }
}
