import 'package:rrms/_all.dart';

abstract class AuthRepository {
  Future<Result> signIn(SignInRequestModel model);
  Future<Result> signOut();
  Future<bool> isAuthenticated();
}

class AuthRepositoryImpl implements AuthRepository {
  final RestApiClient restApiClient;

  AuthRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result> signIn(SignInRequestModel model) async {
    final result = await restApiClient.post(
      '/api/auth/sign-in',
      data: model.toJson(),
      parser: (data) => SignInResponseModel.fromJson(data),
    );

    await _authenticate(
      result.data?.accessToken ?? '',
      result.data?.refreshToken ?? '',
    );

    return result;
  }

  @override
  Future<Result> signOut() async {
    await _deAuthenticate();

    return Result.success();
  }

  @override
  Future<bool> isAuthenticated() async => await restApiClient.isAuthorized();

  Future<void> _authenticate(String accessToken, String refreshToken) async {
    await restApiClient.authorize(jwt: accessToken, refreshToken: refreshToken);
  }

  Future<void> _deAuthenticate() async => await restApiClient.unAuthorize();
}
