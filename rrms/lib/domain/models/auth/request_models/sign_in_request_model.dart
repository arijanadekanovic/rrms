class SignInRequestModel {
  final String? emailOrUserName;
  final String? password;

  SignInRequestModel({
    this.emailOrUserName,
    this.password,
  });

  SignInRequestModel copyWith({
    String? emailOrUserName,
    String? password,
  }) {
    return SignInRequestModel(
      emailOrUserName: emailOrUserName ?? this.emailOrUserName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'emailOrUserName': emailOrUserName,
      'password': password,
    };
  }
}
