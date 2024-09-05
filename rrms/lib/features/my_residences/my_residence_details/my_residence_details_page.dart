import 'package:rrms/_all.dart';

class MyResidenceDetailsPage extends StatelessWidget {
  static const route = '/my-residence-details';

  final ResidenceResponseModel residence;

  const MyResidenceDetailsPage({
    super.key,
    required this.residence,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: RRMSAppBar(
        title: residence.name,
        actions: [
          IconButton(
            onPressed: () => context.push(ResidenceUpdatePage.route, extra: residence.id),
            icon: Icon(Icons.edit),
          ),
          ResidenceDeleteButton(id: residence.id.value),
          const Gap(10),
        ],
      ),
      body: BlocProvider(
        create: (context) => services.get<NavigationCubit>(),
        child: Column(
          children: [
            Container(
              color: context.theme.appBarTheme.backgroundColor,
              child: Row(
                children: [
                  _TabButton(text: 'Overview', index: 0),
                  _TabButton(text: 'Residents', index: 1),
                  _TabButton(text: 'Payments', index: 2),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, navigationState) => switch (navigationState.index) {
                  0 => ResidenceDetailsContent(id: residence.id.value, allowActions: false),
                  1 => ResidentsContent(residenceId: residence.id.value),
                  2 => MyResidencePayments(residenceId: residence.id.value),
                  _ => const SizedBox(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final int index;

  const _TabButton({
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, navigationState) {
          bool isActive = index == navigationState.index;

          return Button(
            child: Text(
              text,
              style: context.textStyle.t14500.withColor(isActive ? context.appTheme.accentColor : Colors.white),
            ),
            borderRadius: 0,
            onTap: () => context.read<NavigationCubit>().update(index),
          );
        },
      ),
    );
  }
}
