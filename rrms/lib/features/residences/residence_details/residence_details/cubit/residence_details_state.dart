import 'package:rrms/_all.dart';

enum ResidenceDetailsStateStatus {
  loading,
  loaded,
}

class ResidenceDetailsState {
  final ResidenceDetailsStateStatus status;
  final ResidenceDetailsResponseModel? details;

  ResidenceDetailsState({
    required this.status,
    this.details,
  });

  factory ResidenceDetailsState.initial() => ResidenceDetailsState(
        status: ResidenceDetailsStateStatus.loading,
      );

  ResidenceDetailsState copyWith({
    ResidenceDetailsStateStatus? status,
    ResidenceDetailsResponseModel? details,
  }) {
    return ResidenceDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
