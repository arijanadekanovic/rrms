import 'package:rrms/_all.dart';

RestApiClient get restApiClient => services.get<RestApiClient>();

class ApiClientConfiguration {
  static Future configure() async {
    final RestApiClient restApiClient = RestApiClientImpl(
      options: RestApiClientOptions(
        baseUrl: appSettings.mainApiUrl,
      ),
      authOptions: AuthOptions(
        refreshTokenEndpoint: '/api/auth/refresh-token',
        refreshTokenBodyBuilder: (jwt, refreshToken) => {
          'accessToken': jwt,
          'refreshToken': refreshToken,
        },
        resolveJwt: (response) => response.data['accessToken'],
        resolveRefreshToken: (response) => response.data['refreshToken'],
      ),
      loggingOptions: appSettings.loggingOptions,
      exceptionOptions: ExceptionOptions(
        resolveValidationErrorsMap: (response) {
          try {
            final keys = ['code', 'Code', 'title', 'Title'];
            final key = keys.firstOrDefault((key) => response.data[key] != null);

            return {
              if (key.isNotNullOrEmpty) 'ERROR': [response.data[key]]
            };
          } catch (e) {
            return {};
          }
        },
      ),
      cacheOptions: CacheOptions(
        useAuthorization: true,
        cacheLifetimeDuration: const Duration(days: 10),
      ),
    );

    await restApiClient.init();

    if (appSettings.resetStorage) {
      await restApiClient.clearStorage();
    }

    if (environment.isMock) {
      await restApiClient.authorize(jwt: 'JWT', refreshToken: 'REFRESH_TOKEN');
    }

    services.registerSingleton<RestApiClient>(restApiClient);
  }
}
