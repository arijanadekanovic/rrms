import 'package:rrms/_all.dart';

enum ResidencesRecommendationStateStatus {
  loading,
  loaded,
}

class ResidencesRecommendationState {
  final ResidencesRecommendationStateStatus status;
  final int? id;
  final List<ResidenceRecommendationResponseModel> residences;

  ResidencesRecommendationState({
    required this.status,
    this.id,
    required this.residences,
  });

  factory ResidencesRecommendationState.initial() => ResidencesRecommendationState(
        status: ResidencesRecommendationStateStatus.loaded,
        residences: [],
      );

  ResidencesRecommendationState copyWith({
    ResidencesRecommendationStateStatus? status,
    int? id,
    List<ResidenceRecommendationResponseModel>? residences,
  }) {
    return ResidencesRecommendationState(
      status: status ?? this.status,
      id: id ?? this.id,
      residences: residences ?? this.residences,
    );
  }
}
