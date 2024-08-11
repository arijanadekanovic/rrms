import 'package:rrms/_all.dart';

enum SignUpStateStatus {
  initial,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class SignUpState extends Event {
  final SignUpStateStatus status;
  final SignUpRequestModel model;
  final SignUpRequestModelValidator modelValidator;

  AutovalidateMode get autovalidateMode => status == SignUpStateStatus.initialSubmitted ? AutovalidateMode.always : AutovalidateMode.disabled;

  SignUpState({
    required this.status,
    required this.model,
    required this.modelValidator,
  });

  factory SignUpState.initial(SignUpRequestModelValidator modelValidator) => SignUpState(
        status: SignUpStateStatus.initial,
        model: SignUpRequestModel(
          role: AppRole.resident,
        ),
        modelValidator: modelValidator,
      );

  SignUpState copyWith({
    SignUpStateStatus? status,
    SignUpRequestModel? model,
    SignUpRequestModelValidator? modelValidator,
  }) {
    return SignUpState(
      status: status ?? this.status,
      model: model ?? this.model,
      modelValidator: modelValidator ?? this.modelValidator,
    );
  }
}
