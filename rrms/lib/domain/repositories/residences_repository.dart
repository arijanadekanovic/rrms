import 'package:rrms/_all.dart';

abstract class ResidencesRepository {
  Future<Result<List<ResidenceResponseModel>>> get();
}

class ResidencesRepositoryImpl implements ResidencesRepository {
  final RestApiClient restApiClient;

  ResidencesRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<List<ResidenceResponseModel>>> get() async {
    final result = await restApiClient.get<List<ResidenceResponseModel>>(
      '/api/residence/residences',
      parser: (data) => data.map<ResidenceResponseModel>((x) => ResidenceResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
