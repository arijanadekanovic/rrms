import 'package:rrms/_all.dart';

enum UsersStateStatus {
  loading,
  loaded,
}

class UsersState {
  final UsersStateStatus status;
  final List<UserResponseModel> users;

  UsersState({
    required this.status,
    required this.users,
  });

  factory UsersState.initial() => UsersState(
        status: UsersStateStatus.loaded,
        users: [],
      );

  UsersState copyWith({
    UsersStateStatus? status,
    List<UserResponseModel>? users,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
