import 'package:rrms/_all.dart';

class RRMSBasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool showNotifications;
  final bool showActions;

  const RRMSBasicAppBar({
    super.key,
    this.leading,
    this.showNotifications = true,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return RRMSAppBar(
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
