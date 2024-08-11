import 'package:rrms/_all.dart';

class SignOutListTile extends StatelessWidget {
  const SignOutListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () => context.read<SignOutCubit>().submit(),
      child: Text(
        'Sign out',
        style: context.textStyle.t16400.withColor(context.appTheme.danger),
      ),
      leading: Icon(
        Icons.logout,
        color: context.appTheme.danger,
      ),
    );
  }
}
