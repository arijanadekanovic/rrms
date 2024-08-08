import 'package:rrms/_all.dart';

class AppFilterChip extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;

  const AppFilterChip({
    super.key,
    this.icon,
    this.title,
    this.isSelected = false,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      borderRadius: 6,
      color: context.theme.cardColor,
      onTap: onTap,
      margin: margin,
      padding: const EdgeInsets.all(10),
      borderColor: isSelected ? context.theme.primaryColor : Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: isSelected ? context.theme.primaryColor : context.primaryTextStyle.color,
              size: 16,
            ),
          if (icon != null && title.isNotNullOrEmpty) const Gap(5),
          if (title.isNotNullOrEmpty)
            Text(
              title.value,
              style: context.textStyle.t12400.withColor(isSelected ? context.theme.primaryColor : context.primaryTextStyle.color),
            ),
        ],
      ),
    );
  }
}
