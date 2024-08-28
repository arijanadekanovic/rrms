import 'package:rrms/_all.dart';

enum ResidenceAddStateStatus {
  initial,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class ResidenceAddState extends Event {
  final ResidenceAddStateStatus status;
  final ResidenceAddRequestModel model;
  final ResidenceAddRequestModelValidator modelValidator;

  AutovalidateMode get autovalidateMode => status == ResidenceAddStateStatus.initialSubmitted ? AutovalidateMode.always : AutovalidateMode.disabled;

  ResidenceAddState({
    required this.status,
    required this.model,
    required this.modelValidator,
  });

  factory ResidenceAddState.initial(ResidenceAddRequestModelValidator modelValidator) => ResidenceAddState(
        status: ResidenceAddStateStatus.initial,
        model: ResidenceAddRequestModel(
          type: ResidenceType.apartment,
        ),
        modelValidator: modelValidator,
      );

  ResidenceAddState copyWith({
    ResidenceAddStateStatus? status,
    ResidenceAddRequestModel? model,
    ResidenceAddRequestModelValidator? modelValidator,
  }) {
    return ResidenceAddState(
      status: status ?? this.status,
      model: model ?? this.model,
      modelValidator: modelValidator ?? this.modelValidator,
    );
  }
}
