import 'package:rrms/_all.dart';

enum ResidenceDeleteStateStatus {
  initial,
  submitting,
  submittingSuccess,
  submittingError,
}

class ResidenceDeleteState implements Event {
  final ResidenceDeleteStateStatus status;
  final int? id;

  ResidenceDeleteState({
    required this.status,
    this.id,
  });

  factory ResidenceDeleteState.initial() => ResidenceDeleteState(
        status: ResidenceDeleteStateStatus.initial,
      );

  ResidenceDeleteState copyWith({
    ResidenceDeleteStateStatus? status,
    Optional<int>? id,
  }) {
    return ResidenceDeleteState(
      status: status ?? this.status,
      id: id != null ? id.value : this.id,
    );
  }
}
