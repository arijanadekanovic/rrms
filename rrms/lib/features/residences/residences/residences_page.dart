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
              if (residencesState.status == ResidencesStateStatus.loading && residencesState.residences.isNullOrEmpty) {
                return ResidencesShimmer();
              }

              return ResponsiveLayoutBuilder(
                small: (context, child) => ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  itemCount: residencesState.residences.count + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ResidencesFilters();
                    }

                    final residence = residencesState.residences[index - 1];

                    return ResidenceListTile(
                      onTap: () => context.push(
                        ResidenceDetailsPage.route,
                        extra: ResidenceDetailsPageModel(
                          title: residence.name.value,
                          id: residence.id.value,
                        ),
                      ),
                      residence: residence,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Gap(15),
                ),
                large: (context, child) => Column(
                  children: [
                    const Gap(20),
                    ResidencesFilters(),
                    const Gap(20),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        itemCount: residencesState.residences.count,
                        itemBuilder: (context, index) {
                          final residence = residencesState.residences[index];

                          return ResidenceListTile(
                            onTap: () => context.push(
                              ResidenceDetailsPage.route,
                              extra: ResidenceDetailsPageModel(
                                title: residence.name.value,
                                id: residence.id.value,
                              ),
                            ),
                            residence: residence,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.5,
                        ),
                        // separatorBuilder: (BuildContext context, int index) => const Gap(15),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
