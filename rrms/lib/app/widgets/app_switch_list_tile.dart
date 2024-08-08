import 'package:rrms/_all.dart';

class AppSwitchListTile extends StatelessWidget {
  final Widget? leading;
  final double? leadingGap;
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const AppSwitchListTile({
    super.key,
    this.leading,
    this.leadingGap,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.isSelected = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      trailing: Switch(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: isSelected,
        onChanged: (_) {},
        activeTrackColor: context.appTheme.accentColor,
      ),
      isSelected: isSelected,
      onTap: onTap,
      padding: padding,
    );
  }
}
