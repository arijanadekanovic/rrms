import 'package:rrms/_all.dart';

abstract class PaymentsRepository {
  Future<Result<List<PaymentResponseModel>>> get();
  Future<Result<PaymentResponseModel>> processPayment(double amount);
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  final RestApiClient restApiClient;

  PaymentsRepositoryImpl({
    required this.restApiClient,
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
  Future<Result<List<PaymentResponseModel>>> get() async {
    final result = await restApiClient.get<List<PaymentResponseModel>>(
      '/api/payment/payments',
      parser: (data) => data.map<PaymentResponseModel>((x) => PaymentResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
