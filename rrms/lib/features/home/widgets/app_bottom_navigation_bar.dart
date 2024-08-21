import 'package:rrms/_all.dart';

class AppBottomNavigationBar extends StatelessWidget {
  static const String navigationKeyResidences = 'app-bottom-navigation-bar-apartments';
  static const String navigationKeyPayments = 'app-bottom-navigation-bar-payments';

  const AppBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, Platform.isIOS ? 20 : 0),
      decoration: BoxDecoration(
        color: context.theme.bottomNavigationBarTheme.backgroundColor,
        border: Border(
          top: BorderSide(
            color: context.appTheme.separator,
          ),
        ),
      ),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, profileState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AppBottomNavigationBarItem(
                  icon: Icons.home,
                  label: 'Residences',
                  index: 0,
                  data: AppBottomNavigationBar.navigationKeyResidences,
                ),
              ),
              if (profileState.isResident)
                Expanded(
                  child: AppBottomNavigationBarItem(
                    icon: Icons.payment_outlined,
                    label: 'Payments',
                    index: 1,
                    data: AppBottomNavigationBar.navigationKeyPayments,
                  ),
                ),
              Expanded(
                child: AppBottomNavigationBarItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  index: 2,
                  data: AppBottomNavigationBar.navigationKeyPayments,
                ),
              ),
              Expanded(
                child: AppBottomNavigationBarItem(
                  icon: Icons.person,
                  label: 'Profile',
                  index: 3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
