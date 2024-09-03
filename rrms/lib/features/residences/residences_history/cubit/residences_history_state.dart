import 'package:rrms/_all.dart';

enum ResidencesHistoryStateStatus {
  loading,
  loaded,
}

class ResidencesHistoryState {
  final ResidencesHistoryStateStatus status;
  final List<ResidencesHistoryResponseModel> residencesHistory;

  ResidencesHistoryState({
    required this.status,
    required this.residencesHistory,
  });

  factory ResidencesHistoryState.initial() => ResidencesHistoryState(
        status: ResidencesHistoryStateStatus.loaded,
        residencesHistory: [],
      );

  ResidencesHistoryState copyWith({
    ResidencesHistoryStateStatus? status,
    List<ResidencesHistoryResponseModel>? residencesHistory,
  }) {
    return ResidencesHistoryState(
      status: status ?? this.status,
      residencesHistory: residencesHistory ?? this.residencesHistory,
    );
  }
}
