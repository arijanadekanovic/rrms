import 'package:rrms/_all.dart';

enum ResidenceUpdateStateStatus {
  initializing,
  initialized,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class ResidenceUpdateState extends Event {
  final ResidenceUpdateStateStatus status;
  final ResidenceUpdateRequestModel model;
  final ResidenceUpdateRequestModelValidator modelValidator;

  AutovalidateMode get autovalidateMode => status == ResidenceUpdateStateStatus.initialSubmitted ? AutovalidateMode.always : AutovalidateMode.disabled;

  ResidenceUpdateState({
    required this.status,
    required this.model,
    required this.modelValidator,
  });

  factory ResidenceUpdateState.initial(ResidenceUpdateRequestModelValidator modelValidator) => ResidenceUpdateState(
        status: ResidenceUpdateStateStatus.initializing,
        model: ResidenceUpdateRequestModel(
          type: ResidenceType.apartment,
        ),
        modelValidator: modelValidator,
      );

  ResidenceUpdateState copyWith({
    ResidenceUpdateStateStatus? status,
    ResidenceUpdateRequestModel? model,
    ResidenceUpdateRequestModelValidator? modelValidator,
  }) {
    return ResidenceUpdateState(
      status: status ?? this.status,
      model: model ?? this.model,
      modelValidator: modelValidator ?? this.modelValidator,
    );
  }
}
