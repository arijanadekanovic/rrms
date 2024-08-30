import 'package:rrms/_all.dart';

enum ResidentStatusUpdateStateStatus {
  initial,
  submitting,
  submittingSuccess,
  submittingError,
}

class ResidentStatusUpdateState extends Event {
  final ResidentStatusUpdateStateStatus status;
  final ResidentStatusUpdateRequestModel? model;

  ResidentStatusUpdateState({
    required this.status,
    this.model,
  });

  factory ResidentStatusUpdateState.initial() => ResidentStatusUpdateState(
        status: ResidentStatusUpdateStateStatus.initial,
      );

  ResidentStatusUpdateState copyWith({
    ResidentStatusUpdateStateStatus? status,
    ResidentStatusUpdateRequestModel? model,
  }) {
    return ResidentStatusUpdateState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
