import 'package:rrms/_all.dart';

class ResidencesPage extends StatelessWidget {
  const ResidencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => services.get<ResidencesCubit>()..load(),
          child: BlocBuilder<ResidencesCubit, ResidencesState>(
            builder: (context, residencesState) {
              if (residencesState.status == ResidencesStateStatus.loading) {
                return Loader();
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: residencesState.residences.count,
                itemBuilder: (context, index) => ResidenceListTile(residence: residencesState.residences[index]),
                separatorBuilder: (BuildContext context, int index) => const Gap(15),
              );
            },
          ),
        ),
      ),
    );
  }
}
