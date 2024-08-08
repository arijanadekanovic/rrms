import 'package:rrms/_all.dart';

enum ResidencesStateStatus {
  loading,
  loaded,
}

class ResidencesState extends Event {
  final ResidencesStateStatus status;
  final List<ResidenceResponseModel> residences;

  ResidencesState({
    required this.status,
    required this.residences,
  });

  factory ResidencesState.initial() => ResidencesState(
        status: ResidencesStateStatus.loaded,
        residences: [],
      );

  ResidencesState copyWith({
    ResidencesStateStatus? status,
    List<ResidenceResponseModel>? residences,
  }) {
    return ResidencesState(
      status: status ?? this.status,
      residences: residences ?? this.residences,
    );
  }
}
