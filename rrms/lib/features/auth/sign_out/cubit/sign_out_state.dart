import 'package:rrms/_all.dart';

enum SignOutStateStatus {
  initial,
  submitting,
  submittingSuccess,
}

class SignOutState implements Event {
  final SignOutStateStatus status;

  SignOutState({
    required this.status,
  });

  factory SignOutState.initial() => SignOutState(
        status: SignOutStateStatus.initial,
      );

  SignOutState copyWith({
    SignOutStateStatus? status,
  }) {
    return SignOutState(
      status: status ?? this.status,
    );
  }
}
