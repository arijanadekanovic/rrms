import 'package:rrms/_all.dart';

abstract class AccountRepository {
  Future<Result> signUp(SignUpRequestModel model);
}

class AccountRepositoryImpl implements AccountRepository {
  final RestApiClient restApiClient;

  AccountRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result> signUp(SignUpRequestModel model) async {
    final result = await restApiClient.post(
      '/api/account/sign-up',
      data: model.toJson(),
    );

    return result;
  }
}
