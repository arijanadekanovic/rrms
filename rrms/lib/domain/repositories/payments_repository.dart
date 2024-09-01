import 'package:rrms/_all.dart';

abstract class PaymentsRepository {
  Future<Result<List<PaymentResponseModel>>> get(PaymentSearchRequestModel searchModel);
  Future<Result> add(PaymentAddRequestModel model);
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  final RestApiClient restApiClient;
  final MediaStorageService mediaStorageService;

  PaymentsRepositoryImpl({
    required this.restApiClient,
    required this.mediaStorageService,
  });

  @override
  Future<Result> add(PaymentAddRequestModel model) async {
    if (model.slip != null) {
      final slipUrlResult = await mediaStorageService.upload(model.slip!);
      model.slipUrl = slipUrlResult.data;
    }

    final result = await restApiClient.post(
      '/api/payment/add',
      data: model.toJson(),
    );

    return result;
  }

  @override
  Future<Result<List<PaymentResponseModel>>> get(PaymentSearchRequestModel searchModel) async {
    final result = await restApiClient.get<List<PaymentResponseModel>>(
      '/api/payment/payments',
      queryParameters: searchModel.toJson(),
      parser: (data) => data.map<PaymentResponseModel>((x) => PaymentResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
