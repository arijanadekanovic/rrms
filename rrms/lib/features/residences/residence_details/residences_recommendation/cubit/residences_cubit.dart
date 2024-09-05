import 'package:rrms/_all.dart';

class ResidencesRecommendationCubit extends Cubit<ResidencesRecommendationState> {
  final ResidencesRepository residencesRepository;

  ResidencesRecommendationCubit({
    required this.residencesRepository,
  }) : super(ResidencesRecommendationState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ResidencesRecommendationStateStatus.loading));

    final result = await residencesRepository.get();

    emit(
      state.copyWith(
        status: ResidencesRecommendationStateStatus.loaded,
        searchModel: searchModel,
        residences: result.data,
      ),
    );
  }

  void updateSearchModel(ResidencesRecommendationSearchRequestModel searchModel) {
    emit(state.copyWith(searchModel: searchModel));
  }

  @override
  void onEvent(Object event) {
    if (event is ResidenceAddState && event.status == ResidenceAddStateStatus.submittingSuccess) load();
    if (event is ResidenceDeleteState && event.status == ResidenceDeleteStateStatus.submittingSuccess) load();
  }
}
