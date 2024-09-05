import 'package:rrms/_all.dart';

class ResidencesRecommendationList extends StatelessWidget {
  const ResidencesRecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => services.get<ResidencesRecommendationCubit>()..load(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Text(
            'Recommended residences:',
            style: context.textStyle.t16600,
          ),
          const Gap(20),
          SizedBox(
            height: 300,
            child: BlocBuilder<ResidencesRecommendationCubit, ResidencesRecommendationState>(
              builder: (context, residencesRecommendationState) {
                if (residencesRecommendationState.status == ResidencesRecommendationStateStatus.loading) {
                  return const Loader();
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: residencesRecommendationState.residences.count,
                  itemBuilder: (context, index) => ResidenceRecommendationListTile(
                    residence: residencesRecommendationState.residences[index],
                  ),
                  separatorBuilder: (context, index) => const Gap(20),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
