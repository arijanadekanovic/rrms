import 'package:rrms/_all.dart';

class SignUpRequestModel {
  final String? email;
  final String? username;
  final String? password;
  final String? firstName;
  final String? lastName;
  final AppRole? role;
  final String? profilePhotoUrl;

  SignUpRequestModel({
    this.email,
    this.username,
    this.password,
    this.firstName,
    this.lastName,
    this.role,
    this.profilePhotoUrl,
  });

  SignUpRequestModel copyWith({
    String? email,
    String? username,
    String? password,
    String? firstName,
    String? lastName,
    AppRole? role,
    String? profilePhotoUrl,
  }) {
    return SignUpRequestModel(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'role': role?.name,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }
}
