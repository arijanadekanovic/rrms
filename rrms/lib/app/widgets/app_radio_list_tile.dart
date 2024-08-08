import 'package:rrms/_all.dart';

class AppRadioListTile extends StatelessWidget {
  final Widget? leading;
  final double? leadingGap;
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? child;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const AppRadioListTile({
    super.key,
    this.leading,
    this.leadingGap,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.child,
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
      trailing: Radio(
        value: isSelected ? 1 : 0,
        groupValue: 1,
        onChanged: (_) {},
      ),
      isSelected: isSelected,
      onTap: onTap,
      padding: padding,
      child: child,
    );
  }
}
