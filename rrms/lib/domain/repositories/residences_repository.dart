import 'package:rrms/_all.dart';

abstract class ResidencesRepository {
  Future<Result<List<ResidenceResponseModel>>> get(ResidencesSearchRequestModel searchModel);
  Future<Result<ResidenceDetailsResponseModel>> getById(int id);
  Future<Result> add(ResidenceAddRequestModel model);
  Future<Result> delete(int id);
}

class ResidencesRepositoryImpl implements ResidencesRepository {
  final RestApiClient restApiClient;
  final MediaStorageService mediaStorageService;

  ResidencesRepositoryImpl({
    required this.restApiClient,
    required this.mediaStorageService,
  });

  @override
  Future<Result<List<ResidenceResponseModel>>> get(ResidencesSearchRequestModel searchModel) async {
    final result = await restApiClient.get<List<ResidenceResponseModel>>(
      '/api/residence/residences',
      queryParameters: searchModel.toJson(),
      parser: (data) => parseList(data, ResidenceResponseModel.fromJson),
    );

    return result;
  }

  @override
  Future<Result<ResidenceDetailsResponseModel>> getById(int id) async {
    final result = await restApiClient.get<ResidenceDetailsResponseModel>(
      '/api/residence/details/$id',
      parser: (data) => ResidenceDetailsResponseModel.fromJson(data),
    );

    return result;
  }

  @override
  Future<Result> add(ResidenceAddRequestModel model) async {
    if (model.thumbnail != null) {
      // final thumbnailUrlResult = await mediaStorageService.upload(model.thumbnail!);
      // model.thumbnailUrl = thumbnailUrlResult.data;

      model.thumbnailUrl = 'https://localhost:5003/storage-files/9cbe4c2c-8117-427e-b770-76cf8c5a1a8f.jpg';

      final result = await restApiClient.post(
        '/api/residence/add',
        data: model.toJson(),
      );

      return result;
    }

    return Result.error(exception: Exception('Validation error'));
  }

  @override
  Future<Result> delete(int id) async {
    final result = await restApiClient.delete('/api/residence/$id');

    return result;
  }
}
