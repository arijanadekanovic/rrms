import 'package:rrms/_all.dart';

abstract class AccountRepository {
  Future<Result> signUp(SignUpRequestModel model);
  Future<Result<AccountDetailsResponseModel>> getAccountDetails();
  Future<Result<AccountUpdateRequestModel>> prepareForUpdate();
  Future<Result> update(AccountUpdateRequestModel model);
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

  @override
  Future<Result<AccountUpdateRequestModel>> prepareForUpdate() async {
    final result = await restApiClient.get(
      '/api/account/account-details',
      parser: (data) {
        var details = AccountDetailsResponseModel.fromJson(data);

        return AccountUpdateRequestModel(
          firstName: details.firstName,
          lastName: details.lastName,
          phoneNumber: details.phoneNumber,
          profilePhotoUrl: details.profilePhotoUrl,
        );
      },
    );

    return result;
  }

  @override
  Future<Result> update(AccountUpdateRequestModel model) async {
    final result = await restApiClient.patch(
      '/api/account/update',
      data: model.toJson(),
    );

    return result;
  }
}
