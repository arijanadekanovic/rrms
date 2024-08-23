import 'package:rrms/_all.dart';

abstract class ResidentsRepository {
  Future<Result<List<ResidentResponseModel>>> get(ResidentsSearchRequestModel searchModel);
}

class ResidentsRepositoryImpl implements ResidentsRepository {
  final RestApiClient restApiClient;

  ResidentsRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<List<ResidentResponseModel>>> get(ResidentsSearchRequestModel searchModel) async {
    final result = await restApiClient.get<List<ResidentResponseModel>>(
      '/api/resident/residents',
      queryParameters: searchModel.toJson(),
      parser: (data) => parseList(data, ResidentResponseModel.fromJson),
    );

    return result;
  }
}
