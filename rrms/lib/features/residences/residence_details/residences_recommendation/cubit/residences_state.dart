import 'package:rrms/_all.dart';

enum ResidencesRecommendationStateStatus {
  loading,
  loaded,
}

class ResidencesRecommendationState {
  final ResidencesRecommendationStateStatus status;
  final List<ResidenceRecommendationResponseModel> residences;

  ResidencesRecommendationState({
    required this.status,
    required this.searchModel,
    required this.residences,
  });

  factory ResidencesRecommendationState.initial() => ResidencesRecommendationState(
        status: ResidencesRecommendationStateStatus.loaded,
        searchModel: ResidencesRecommendationSearchRequestModel(),
        residences: [],
      );

  ResidencesRecommendationState copyWith({
    ResidencesRecommendationStateStatus? status,
    ResidencesRecommendationSearchRequestModel? searchModel,
    List<ResidenceResponseModel>? residences,
  }) {
    return ResidencesRecommendationState(
      status: status ?? this.status,
      searchModel: searchModel ?? this.searchModel,
      residences: residences ?? this.residences,
    );
  }
}
