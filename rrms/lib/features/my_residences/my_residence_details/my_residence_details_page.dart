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
            onPressed: () {
              // TODO: PUSH RESIDENCE UPDATE PAGE
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // TODO: SHOW WARNING DIALOG TO DELETE RESIDENCE
            },
            icon: Icon(Icons.delete, color: context.appTheme.danger),
          ),
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
                  _TabButton(text: 'Tenants', index: 1),
                  _TabButton(text: 'Payments', index: 2),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, navigationState) => switch (navigationState.index) {
                  0 => ResidenceDetailsContent(residence: residence),
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
