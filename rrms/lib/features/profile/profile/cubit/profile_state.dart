import 'package:rrms/_all.dart';

enum ProfileStateStatus {
  loading,
  loaded,
}

class ProfileState {
  final ProfileStateStatus status;
  final AccountDetailsResponseModel? accountDetails;

  bool get isSuperAdmin => accountDetails?.roles?.contains(AppRole.superadmin) ?? false;
  bool get isLandlord => accountDetails?.roles?.contains(AppRole.landlord) ?? false;
  bool get isResident => accountDetails?.roles?.contains(AppRole.resident) ?? false;

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
