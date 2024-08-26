import 'package:rrms/_all.dart';

abstract class PaymentsRepository {
  Future<Result<List<PaymentResponseModel>>> get();
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  final RestApiClient restApiClient;

  PaymentsRepositoryImpl({
    required this.restApiClient,
  });

  // TODO: WIP processPayment
  // @override
  // Future<Result<PaymentResponseModel>> processPayment(double amount) async {
  //   final result = await restApiClient.post<PaymentResponseModel>(
  //     '/api/payments/process',
  //     data: {'amount': amount},
  //     parser: (data) => PaymentResponseModel.fromJson(data),
  //   );

  //   return result;
  // }

  @override
  Future<Result<List<PaymentResponseModel>>> get() async {
    final result = await restApiClient.get<List<PaymentResponseModel>>(
      '/api/payment/payments',
      parser: (data) => data.map<PaymentResponseModel>((x) => PaymentResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
