import 'package:rrms/_all.dart';

abstract class CitiesRepository {
  Future<Result<List<CityResponseModel>>> get();
}

class CitiesRepositoryImpl implements CitiesRepository {
  final RestApiClient restApiClient;

  CitiesRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<List<CityResponseModel>>> get() async {
    final result = await restApiClient.get<List<CityResponseModel>>(
      '/api/city/cities',
      onSuccess: (data) => data.map<CityResponseModel>((x) => CityResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
