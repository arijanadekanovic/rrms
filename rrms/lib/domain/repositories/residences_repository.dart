import 'package:rrms/_all.dart';

abstract class ResidencesRepository {
  Future<Result<List<ResidenceResponseModel>>> get(ResidencesSearchRequestModel searchModel);
  Future<Result<List<ResidenceRecommendationResponseModel>>> getRecommendedById(int id);
  Future<Result<List<ResidencesHistoryResponseModel>>> getHistory();
  Future<Result<ResidenceDetailsResponseModel>> getById(int id);
  Future<Result> add(ResidenceAddRequestModel model);
  Future<Result<ResidenceUpdateRequestModel>> prepareForUpdate(int id);
  Future<Result> update(ResidenceUpdateRequestModel model);
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
  Future<Result<List<ResidenceRecommendationResponseModel>>> getRecommendedById(int id) async {
    final result = await restApiClient.get<List<ResidenceRecommendationResponseModel>>(
      '/api/residence/residences-recommendation/$id',
      parser: (data) => parseList(data, ResidenceRecommendationResponseModel.fromJson),
    );

    return result;
  }

  @override
  Future<Result<List<ResidencesHistoryResponseModel>>> getHistory() async {
    final result = await restApiClient.get<List<ResidencesHistoryResponseModel>>(
      '/api/residence/residences-history',
      parser: (data) => data.map<ResidencesHistoryResponseModel>((x) => ResidencesHistoryResponseModel.fromJson(x)).toList(),
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
      final thumbnailUrlResult = await mediaStorageService.upload(model.thumbnail!);
      model.thumbnailUrl = thumbnailUrlResult.data;
    }

    final result = await restApiClient.post(
      '/api/residence/add',
      data: model.toJson(),
    );

    return result;
  }

  @override
  Future<Result<ResidenceUpdateRequestModel>> prepareForUpdate(int id) async {
    final result = await restApiClient.get(
      '/api/residence/details/$id',
      parser: (data) {
        var details = ResidenceDetailsResponseModel.fromJson(data);

        return ResidenceUpdateRequestModel(
          id: details.id,
          name: details.name,
          description: details.description,
          address: details.address,
          rooms: details.rooms,
          size: details.size,
          rentPrice: details.rentPrice,
          type: details.type,
          thumbnailUrl: details.thumbnailUrl,
          cityId: details.city?.id,
        );
      },
    );

    return result;
  }

  @override
  Future<Result> update(ResidenceUpdateRequestModel model) async {
    if (model.thumbnail != null) {
      final thumbnailUrlResult = await mediaStorageService.upload(model.thumbnail!);
      model.thumbnailUrl = thumbnailUrlResult.data;
    }

    final result = await restApiClient.put(
      '/api/residence/update',
      data: model.toJson(),
    );

    return result;
  }

  @override
  Future<Result> delete(int id) async {
    final result = await restApiClient.delete('/api/residence/$id');

    return result;
  }
}
