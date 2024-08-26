import 'package:rrms/_all.dart';

class MyResidencesPage extends StatelessWidget {
  const MyResidencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => services.get<ResidencesCubit>()..load(ResidencesSearchRequestModel(ownedByMe: true)),
          child: BlocBuilder<ResidencesCubit, ResidencesState>(
            builder: (context, residencesState) {
              if (residencesState.status == ResidencesStateStatus.loading && residencesState.residences.isNullOrEmpty) {
                return ResidencesShimmer();
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: residencesState.residences.count,
                itemBuilder: (context, index) {
                  final residence = residencesState.residences[index];

                  return ResidenceListTile(
                    onTap: () => context.push(MyResidenceDetailsPage.route, extra: residence),
                    residence: residence,
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Gap(15),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
            onTap: () => context.push(ResidenceAddPage.route),
            primary: true,
            shrinkWrap: true,
            borderRadius: 50,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
