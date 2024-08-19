import 'package:rrms/_all.dart';

abstract class NotificationsRepository {
  Future<Result<List<NotificationResponseModel>>> get();
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  final RestApiClient restApiClient;

  NotificationsRepositoryImpl({
    required this.restApiClient,
  });

  @override
  Future<Result<List<NotificationResponseModel>>> get() async {
    final result = await restApiClient.get<List<NotificationResponseModel>>(
      '/api/notification/notifications',
      parser: (data) => data.map<NotificationResponseModel>((x) => NotificationResponseModel.fromJson(x)).toList(),
    );

    return result;
  }
}
