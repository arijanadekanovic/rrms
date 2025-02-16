import 'package:rrms/_all.dart';

abstract class UsersRepository {
  Future<Result<List<UserResponseModel>>> get();
}

class UsersRepositoryImpl implements UsersRepository {
  final RestApiClient restApiClient;

  UsersRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<List<UserResponseModel>>> get() async {
    final result = await restApiClient.get<List<UserResponseModel>>(
      '/api/user/users',
      onSuccess: (data) => data.map<UserResponseModel>((x) => UserResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
