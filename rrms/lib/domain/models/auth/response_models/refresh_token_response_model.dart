import 'package:rrms/_all.dart';

class RefreshTokenResponseModel {
  final String? accessToken;
  final String? refreshToken;

  RefreshTokenResponseModel({
    this.accessToken,
    this.refreshToken,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponseModel(
      accessToken: json.parseValue('accessToken'),
      refreshToken: json.parseValue('refreshToken'),
    );
  }
}
