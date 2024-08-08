class RefreshTokenRequestModel {
  final String? token;

  RefreshTokenRequestModel({
    this.token,
  });

  RefreshTokenRequestModel copyWith({
    String? token,
  }) {
    return RefreshTokenRequestModel(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': token,
    };
  }
}
