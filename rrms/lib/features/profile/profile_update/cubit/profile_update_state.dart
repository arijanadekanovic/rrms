import 'package:rrms/_all.dart';

enum ProfileUpdateStateStatus {
  initializing,
  initialized,
  initialSubmitted,
  submitting,
  submittingSuccess,
  submittingError,
  validationError,
}

class ProfileUpdateState implements Event {
  final ProfileUpdateStateStatus status;
  final AccountUpdateRequestModel? model;
  final AccountUpdateRequestModelValidator modelValidator;

  AutovalidateMode get autovalidateMode => status == ProfileUpdateStateStatus.initialSubmitted ? AutovalidateMode.always : AutovalidateMode.disabled;

  ProfileUpdateState({
    required this.status,
    this.model,
    required this.modelValidator,
  });

  factory ProfileUpdateState.initial(AccountUpdateRequestModelValidator modelValidator) => ProfileUpdateState(
        status: ProfileUpdateStateStatus.initializing,
        modelValidator: modelValidator,
      );

  ProfileUpdateState copyWith({
    ProfileUpdateStateStatus? status,
    AccountUpdateRequestModel? model,
    AccountUpdateRequestModelValidator? modelValidator,
  }) {
    return ProfileUpdateState(
      status: status ?? this.status,
      model: model ?? this.model,
      modelValidator: modelValidator ?? this.modelValidator,
    );
  }
}
