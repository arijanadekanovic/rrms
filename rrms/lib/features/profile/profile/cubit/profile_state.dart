import 'package:rrms/_all.dart';

enum ProfileStateStatus {
  loading,
  loaded,
}

class ProfileState {
  final ProfileStateStatus status;
  final AccountDetailsResponseModel? accountDetails;

  ProfileState({
    required this.status,
    this.accountDetails,
  });

  factory ProfileState.initial() => ProfileState(
        status: ProfileStateStatus.loading,
      );

  ProfileState copyWith({
    ProfileStateStatus? status,
    AccountDetailsResponseModel? accountDetails,
  }) {
    return ProfileState(
      status: status ?? this.status,
      accountDetails: accountDetails ?? this.accountDetails,
    );
  }
}
