import 'package:rrms/_all.dart';

class RRMSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool primary;
  final String? title;
  final TextStyle? titleTextStyle;
  final Widget? child;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? color;

  const RRMSAppBar({
    super.key,
    this.primary = false,
    this.title,
    this.titleTextStyle,
    this.child,
    this.leading,
    this.actions,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      centerTitle: !primary,
      backgroundColor: color,
      titleSpacing: primary ? 0 : 20,
      leadingWidth: primary ? 20 : null,
      leading: leading ??
          (primary
              ? const SizedBox(width: 20)
              : IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: context.textStyle.color,
                    size: 30,
                  ),
                  onPressed: () => context.pop(),
                )),
      automaticallyImplyLeading: true,
      title: () {
        if (child != null) {
          return child;
        }

        if (title.isNotNullOrEmpty) {
          return Text(
            title.value,
            style: titleTextStyle ?? (primary ? context.textStyle.t32700 : context.textStyle.t18700),
          );
        }

        return null;
      }(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
