import 'package:rrms/_all.dart';

class RepositoriesConfiguration {
  static Future configure() async {
    services.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        restApiClient: services.get<RestApiClient>(),
      ),
    );
    services.registerSingleton<AccountRepository>(
      AccountRepositoryImpl(
        restApiClient: services.get<RestApiClient>(),
      ),
    );
    services.registerSingleton<ConfigRepository>(
      ConfigRepositoryImpl(
        storageRepository: services.get<StorageRepository>(),
        restApiClient: services.get<RestApiClient>(),
      ),
    );
    services.registerSingleton<ResidencesRepository>(
      ResidencesRepositoryImpl(
        restApiClient: services.get<RestApiClient>(),
      ),
    );
    services.registerSingleton<NotificationsRepository>(
      NotificationsRepositoryImpl(
        restApiClient: services.get<RestApiClient>(),
      ),
    );
    services.registerSingleton<PaymentsRepository>(
      PaymentsRepositoryImpl(
        restApiClient: services.get<RestApiClient>(),
      ),
    );
    services.registerSingleton<CitiesRepository>(
      CitiesRepositoryImpl(
        restApiClient: services.get<RestApiClient>(),
      ),
    );
  }
}
