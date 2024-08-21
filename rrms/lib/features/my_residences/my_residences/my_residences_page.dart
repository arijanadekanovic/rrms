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
          create: (context) => services.get<MyResidencesCubit>()..load(),
          child: BlocBuilder<MyResidencesCubit, MyResidencesState>(
            builder: (context, residencesState) {
              if (residencesState.status == MyResidencesStateStatus.loading && residencesState.myResidences.isNullOrEmpty) {
                return ResidencesShimmer();
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: residencesState.myResidences.count,
                itemBuilder: (context, index) {
                  return MyResidenceListTile(myResidence: residencesState.myResidences[index]);
                },
                separatorBuilder: (BuildContext context, int index) => const Gap(15),
              );
            },
          ),
        ),
      ),
    );
  }
}
