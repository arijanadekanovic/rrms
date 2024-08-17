import 'package:rrms/_all.dart';

abstract class PaymentsRepository {
  Future<Result<List<PaymentsResponseModel>>> get();
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  final RestApiClient restApiClient;

  PaymentsRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<PaymentsResponseModel>> processPayment(double amount) async {
    final result = await restApiClient.post<PaymentsResponseModel>(
      '/api/payments/process',
      data: {'amount': amount},
      parser: (data) => PaymentsResponseModel.fromJson(data),
    );

    return result;
  }

  @override
  Future<Result<List<PaymentsResponseModel>>> get() async {
    final result = await restApiClient.get<List<PaymentsResponseModel>>(
      '/api/payments',
      parser: (data) => data.map<PaymentsResponseModel>((x) => PaymentsResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
