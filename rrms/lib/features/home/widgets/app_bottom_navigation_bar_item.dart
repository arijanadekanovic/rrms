import 'package:rrms/_all.dart';

class AppBottomNavigationBarItem extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final Widget Function(bool isSelected, Color? color)? iconBuilder;
  final void Function()? onTap;
  final String label;
  final int index;
  final dynamic data;

  const AppBottomNavigationBarItem({
    super.key,
    this.icon,
    this.svgPath,
    this.iconBuilder,
    this.onTap,
    required this.label,
    required this.index,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navigationState) {
        final isSelected = navigationState.index == index;
        final color = isSelected ? context.theme.bottomNavigationBarTheme.selectedItemColor : context.theme.bottomNavigationBarTheme.unselectedItemColor;

        return InkWell(
          onTap: onTap ?? () => context.read<NavigationCubit>().update(index, data: data),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              () {
                if (iconBuilder != null) {
                  return iconBuilder!.call(isSelected, color);
                }

                if (icon != null) {
                  return Icon(
                    icon,
                    color: color,
                    size: 28,
                  );
                }

                return const SizedBox();
              }(),
              const Gap(5),
              Text(
                label,
                softWrap: false,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(10),
            ],
          ),
        );
      },
    );
  }
}
