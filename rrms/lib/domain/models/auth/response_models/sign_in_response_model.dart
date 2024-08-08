import 'package:rrms/_all.dart';

class SignInResponseModel {
  final String? accessToken;
  final String? refreshToken;

  SignInResponseModel({
    this.accessToken,
    this.refreshToken,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      accessToken: json.parseValue('accessToken'),
      refreshToken: json.parseValue('refreshToken'),
    );
  }
}
