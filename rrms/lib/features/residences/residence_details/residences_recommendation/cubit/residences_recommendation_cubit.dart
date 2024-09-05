import 'package:rrms/_all.dart';

class ResidencesRecommendationCubit extends Cubit<ResidencesRecommendationState> {
  final ResidencesRepository residencesRepository;

  ResidencesRecommendationCubit({
    required this.residencesRepository,
  }) : super(ResidencesRecommendationState.initial());

  Future<void> load([int? id]) async {
    emit(state.copyWith(status: ResidencesRecommendationStateStatus.loading));

    final result = await residencesRepository.getRecommendedById(id ?? state.id ?? 0);

    emit(
      state.copyWith(
        status: ResidencesRecommendationStateStatus.loaded,
        id: id,
        residences: result.data,
      ),
    );
  }
}
