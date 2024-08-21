import 'package:rrms/_all.dart';

class AccountDetailsResponseModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final List<AppRole>? roles;

  AccountDetailsResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.roles,
  });

  factory AccountDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsResponseModel(
      id: json.parseValue('id'),
      firstName: json.parseValue('firstName'),
      lastName: json.parseValue('lastName'),
      email: json.parseValue('email'),
      username: json.parseValue('username'),
      phoneNumber: json.parseValue('phoneNumber'),
      profilePhotoUrl: json.parseValue('profilePhotoUrl'),
      roles: json['roles'].map<AppRole>((x) => AppRole.parse(x)).toList(),
    );
  }
}
