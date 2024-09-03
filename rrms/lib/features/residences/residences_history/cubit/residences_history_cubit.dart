import 'package:rrms/_all.dart';

class ResidencesHistoryCubit extends Cubit<ResidencesHistoryState> {
  final ResidencesRepository residencesHistoryRepository;

  ResidencesHistoryCubit({
    required this.residencesHistoryRepository,
  }) : super(ResidencesHistoryState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ResidencesHistoryStateStatus.loading));

    final result = await residencesHistoryRepository.getHistory();

    emit(
      state.copyWith(
        status: ResidencesHistoryStateStatus.loaded,
        residencesHistory: result.data,
      ),
    );
  }
}
