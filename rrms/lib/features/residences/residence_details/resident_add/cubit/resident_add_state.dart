import 'package:rrms/_all.dart';

enum ResidentAddStateStatus {
  initial,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class ResidentAddState extends Event {
  final ResidentAddStateStatus status;
  final ResidentAddRequestModel model;
  final ResidentAddRequestModelValidator modelValidator;

  AutovalidateMode get autovalidateMode => status == ResidentAddStateStatus.initialSubmitted ? AutovalidateMode.always : AutovalidateMode.disabled;

  ResidentAddState({
    required this.status,
    required this.model,
    required this.modelValidator,
  });

  factory ResidentAddState.initial(ResidentAddRequestModelValidator modelValidator) => ResidentAddState(
        status: ResidentAddStateStatus.initial,
        model: ResidentAddRequestModel(
          contractStartDate: DateTime.now(),
          contractEndDate: DateTime.now().add(const Duration(days: 365)),
        ),
        modelValidator: modelValidator,
      );

  ResidentAddState copyWith({
    ResidentAddStateStatus? status,
    ResidentAddRequestModel? model,
    ResidentAddRequestModelValidator? modelValidator,
  }) {
    return ResidentAddState(
      status: status ?? this.status,
      model: model ?? this.model,
      modelValidator: modelValidator ?? this.modelValidator,
    );
  }
}
