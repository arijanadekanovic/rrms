import 'package:rrms/_all.dart';

enum ResidentsStateStatus {
  loading,
  loaded,
}

class ResidentsState {
  final ResidentsStateStatus status;
  final ResidentsSearchRequestModel searchModel;
  final List<ResidentResponseModel> residents;

  ResidentsState({
    required this.status,
    required this.searchModel,
    required this.residents,
  });

  factory ResidentsState.initial() => ResidentsState(
        status: ResidentsStateStatus.loaded,
        searchModel: ResidentsSearchRequestModel(),
        residents: [],
      );

  ResidentsState copyWith({
    ResidentsStateStatus? status,
    ResidentsSearchRequestModel? searchModel,
    List<ResidentResponseModel>? residents,
  }) {
    return ResidentsState(
      status: status ?? this.status,
      searchModel: searchModel ?? this.searchModel,
      residents: residents ?? this.residents,
    );
  }
}
