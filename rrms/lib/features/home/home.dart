import 'package:rrms/_all.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<NavigationCubit>(param1: 0),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, navigationState) {
                return switch (navigationState.index) {
                  0 => const ResidencesPage(),
                  1 => const Center(child: Text('Payments')),
                  2 => const Center(child: Text('Menu')),
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
