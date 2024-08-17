import 'package:rrms/_all.dart';

enum ResidencesStateStatus {
  loading,
  loaded,
}

class ResidencesState {
  final ResidencesStateStatus status;
  final ResidencesSearchRequestModel searchModel;
  final List<ResidenceResponseModel> residences;

  ResidencesState({
    required this.status,
    required this.searchModel,
    required this.residences,
  });

  factory ResidencesState.initial() => ResidencesState(
        status: ResidencesStateStatus.loaded,
        searchModel: ResidencesSearchRequestModel(),
        residences: [],
      );

  ResidencesState copyWith({
    ResidencesStateStatus? status,
    ResidencesSearchRequestModel? searchModel,
    List<ResidenceResponseModel>? residences,
  }) {
    return ResidencesState(
      status: status ?? this.status,
      searchModel: searchModel ?? this.searchModel,
      residences: residences ?? this.residences,
    );
  }
}
