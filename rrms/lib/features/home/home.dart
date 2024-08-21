import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/payments_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<NavigationCubit>(param1: 0),
      child: Builder(
        builder: (context) {
          return Scaffold(
            drawer: Drawer(
              backgroundColor: Colors.red,
            ),
            endDrawer: Drawer(
              backgroundColor: Colors.yellow,
            ),
            body: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, navigationState) {
                return switch (navigationState.index) {
                  0 => const ResidencesPage(),
                  1 => const PaymentsPage(residenceName: 'residenceName'),
                  2 => const MyResidencesPage(),
                  3 => const Center(child: Text('Chat')),
                  4 => const ProfilePage(),
                  _ => const Center(child: Text('Invalid navigation index')),
                };
              },
            ),
            bottomNavigationBar: const AppBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
