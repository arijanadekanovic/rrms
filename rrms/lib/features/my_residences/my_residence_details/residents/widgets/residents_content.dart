import 'package:rrms/_all.dart';

class ResidentsContent extends StatelessWidget {
  final int residenceId;

  const ResidentsContent({
    super.key,
    required this.residenceId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocProvider(
        create: (context) => services.get<ResidentsCubit>()..load(ResidentsSearchRequestModel(residenceId: residenceId)),
        child: BlocBuilder<ResidentsCubit, ResidentsState>(
          builder: (context, residencesState) {
            if (residencesState.status == ResidentsStateStatus.loading && residencesState.residents.isNullOrEmpty) {
              return ResidentsShimmer();
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 15),
              itemCount: residencesState.residents.count,
              itemBuilder: (context, index) {
                final resident = residencesState.residents[index];

                return ResidentListTile(
                  // onTap: () => context.push(ResidentDetailsPage.route, extra: resident),
                  resident: resident,
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Gap(15),
            );
          },
        ),
      ),
    );
  }
}
