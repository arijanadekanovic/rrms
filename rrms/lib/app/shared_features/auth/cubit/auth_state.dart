import 'package:rrms/_all.dart';

enum AuthStateStatus {
  authenticated,
  unAuthenticated,
}

class AuthState implements Event {
  AuthStateStatus status;

  bool get isAuthenticated => status == AuthStateStatus.authenticated;
  bool get isUnAuthenticated => status == AuthStateStatus.unAuthenticated;

  AuthState({
    required this.status,
  });

  factory AuthState.initial() => AuthState(
        status: AuthStateStatus.unAuthenticated,
      );

  @override
  AuthState copyWith({
    AuthStateStatus? status,
  }) =>
      AuthState(
        status: status ?? this.status,
      );
}
