class AccountUpdateRequestModel {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profilePhotoUrl;

  AccountUpdateRequestModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profilePhotoUrl,
  });

  AccountUpdateRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) {
    return AccountUpdateRequestModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if(firstName != null) 'firstName': firstName,
      if(lastName != null) 'lastName': lastName,
      if(phoneNumber != null) 'phoneNumber': phoneNumber,
      if(profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
    };
  }
}
