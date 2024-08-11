import 'package:rrms/_all.dart';

abstract class AccountRepository {
  Future<Result> signUp(SignUpRequestModel model);
  Future<Result<AccountDetailsResponseModel>> getAccountDetails();
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

  @override
  Future<Result<AccountDetailsResponseModel>> getAccountDetails() async {
    final result = await restApiClient.get(
      '/api/account/account-details',
      parser: (data) => AccountDetailsResponseModel.fromJson(data),
    );

    return result;
  }
}
