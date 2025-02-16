import 'package:rrms/_all.dart';

class UserResponseModel {
  final String? id;
  final String? fullName;

  UserResponseModel({
    this.id,
    this.fullName,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json.parseValue('id'),
      fullName: json.parseValue('fullName'),
    );
  }
}
