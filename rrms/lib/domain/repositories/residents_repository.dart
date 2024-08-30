import 'package:rrms/_all.dart';

abstract class ResidentsRepository {
  Future<Result<List<ResidentResponseModel>>> get(ResidentsSearchRequestModel searchModel);
  Future<Result> add(ResidentAddRequestModel model);
  Future<Result> statusUpdate(ResidentStatusUpdateRequestModel model);
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

  @override
  Future<Result> add(ResidentAddRequestModel model) async {
    final result = await restApiClient.post(
      '/api/resident/add',
      data: model.toJson(),
    );

    return result;
  }

  @override
  Future<Result> statusUpdate(ResidentStatusUpdateRequestModel model) async {
    final result = await restApiClient.put(
      '/api/resident/status-update',
      data: model.toJson(),
    );

    return result;
  }
}
