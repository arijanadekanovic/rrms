class AccountUpdateRequestModel {
  final String? firstName;
  final String? lastName;
  final String? profilePhotoUrl;

  AccountUpdateRequestModel({
    this.firstName,
    this.lastName,
    this.profilePhotoUrl,
  });

  AccountUpdateRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? profilePhotoUrl,
  }) {
    return AccountUpdateRequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }
}
