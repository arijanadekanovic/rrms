import 'package:rrms/_all.dart';

class ResidencesHistoryPage extends StatelessWidget {
  const ResidencesHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RRMSAppBar(
        title: 'Residences history',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => services.get<ResidencesHistoryCubit>()..load(),
          child: BlocBuilder<ResidencesHistoryCubit, ResidencesHistoryState>(
            builder: (context, residencesHistoryState) {
              if (residencesHistoryState.status == NotificationsStateStatus.loading && residencesHistoryState.residencesHistory.isNullOrEmpty) {
                return Loader();
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                itemCount: residencesHistoryState.residencesHistory.count,
                itemBuilder: (context, index) {
                  return ResidencesHistoryListTile(residencesHistory: residencesHistoryState.residencesHistory[index]);
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
