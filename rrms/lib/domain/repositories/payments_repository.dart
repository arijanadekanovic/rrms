import 'package:rrms/_all.dart';

abstract class PaymentsRepository {
  Future<Result<List<PaymentResponseModel>>> get();
  Future<Result<PaymentResponseModel>> processPayment(double amount);
  Future<Result> addSlip(ProcessPaymentRequestModel model); //SlipAddRequestModel

}

class PaymentsRepositoryImpl implements PaymentsRepository {
  final RestApiClient restApiClient;
   final MediaStorageService mediaStorageService;

  PaymentsRepositoryImpl({
    required this.restApiClient,
    required this.mediaStorageService
  });
  
  @override
  Future<Result<PaymentResponseModel>> processPayment(double amount) async {
    final result = await restApiClient.post<PaymentResponseModel>(
      '/api/payment/payments/process',
      data: {'amount': amount},
      parser: (data) => PaymentResponseModel.fromJson(data),
    );

    return result;
  }

    @override
  Future<Result> addSlip(ProcessPaymentRequestModel model) async { //SlipAddRequestModel
    //  if (model.slipUrl != null) {
    //   final thumbnailUrlResult = await mediaStorageService.upload(model.slipUrl!);
    //   model.slipUrl = thumbnailUrlResult.data;
    // }

    final result = await restApiClient.post(
      '/api/payment/addSlip',
      data: model.toJson(),
    );

    return result;
  }

  @override
  Future<Result<List<PaymentResponseModel>>> get() async {
    final result = await restApiClient.get<List<PaymentResponseModel>>(
      '/api/payment/payments',
      parser: (data) => data.map<PaymentResponseModel>((x) => PaymentResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
