import 'package:rrms/_all.dart';

enum SignInStateStatus {
  initial,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class SignInState extends Event {
  final SignInStateStatus status;
  final SignInRequestModel model;
  final SignInRequestModelValidator modelValidator;

  SignInState({
    required this.status,
    required this.model,
    required this.modelValidator,
  });

  factory SignInState.initial(SignInRequestModelValidator modelValidator) => SignInState(
        status: SignInStateStatus.initial,
        model: SignInRequestModel(),
        modelValidator: modelValidator,
      );

  SignInState copyWith({
    SignInStateStatus? status,
    SignInRequestModel? model,
    SignInRequestModelValidator? modelValidator,
  }) {
    return SignInState(
      status: status ?? this.status,
      model: model ?? this.model,
      modelValidator: modelValidator ?? this.modelValidator,
    );
  }
}
