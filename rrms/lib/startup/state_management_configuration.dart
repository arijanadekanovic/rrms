import 'package:rrms/_all.dart';

class StateManagementConfiguration {
  static void configure() {
    configureSingletons();
    configureScoped();
  }

  static void configureSingletons() {
    final restApiClient = services.get<RestApiClient>();
    final authRepository = services.get<AuthRepository>();
    final accountRepository = services.get<AccountRepository>();
    final configRepository = services.get<ConfigRepository>();
    final citiesRepository = services.get<CitiesRepository>();
    final usersRepository = services.get<UsersRepository>();
    final pushNotificationsService = services.get<PushNotificationsService>();

    services.registerSingleton<IEventBus>(EventBus());

    services.registerSingleton(ErrorHandlerCubit(restApiClient: restApiClient));
    services.registerSingleton(LocalizationCubit(restApiClient: restApiClient, configRepository: configRepository));
    services.registerSingleton(ThemeCubit(configRepository: configRepository));

    services.registerSingleton(AuthCubit(restApiClient: restApiClient, authRepository: authRepository));
    services.registerSingleton(SignOutCubit(authRepository: authRepository));
    services.registerSingleton(PushNotificationsCubit(pushNotificationsService: pushNotificationsService));

    services.registerSingleton(ProfileCubit(accountRepository: accountRepository));
    services.registerSingleton(CitiesCubit(citiesRepository: citiesRepository));
    services.registerSingleton(UsersCubit(usersRepository: usersRepository));
  }

  static void configureScoped() {
    final authRepository = services.get<AuthRepository>();
    final accountRepository = services.get<AccountRepository>();
    final residencesRepository = services.get<ResidencesRepository>();
    final residentsRepository = services.get<ResidentsRepository>();
    final notificationsRepository = services.get<NotificationsRepository>();
    final paymentsRepository = services.get<PaymentsRepository>();
    final chatsRepository = services.get<ChatsRepository>();

    services.registerFactoryParam((int? index, _) => NavigationCubit(index: index.value));
    services.registerFactoryParam((String url, _) => AppPdfViewerCubit(url: url));

    services.registerFactory(() => ResidenceDetailsCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidenceDeleteCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidencesCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidencesRecommendationCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidentsCubit(residentsRepository: residentsRepository));
    services.registerFactory(() => NotificationsCubit(notificationsRepository: notificationsRepository));
    services.registerFactory(() => ResidencesHistoryCubit(residencesHistoryRepository: residencesRepository));
    services.registerFactory(() => PaymentsCubit(paymentsRepository: paymentsRepository));
    services.registerFactory(() => SignInCubit(authRepository: authRepository, modelValidator: services.get<SignInRequestModelValidator>()));
    services.registerFactory(() => SignUpCubit(accountRepository: accountRepository, modelValidator: services.get<SignUpRequestModelValidator>()));
    services.registerFactory(() => ResidenceAddCubit(residencesRepository: residencesRepository, modelValidator: services.get<ResidenceAddRequestModelValidator>()));
    services.registerFactory(() => ProfileUpdateCubit(accountRepository: accountRepository, modelValidator: services.get<AccountUpdateRequestModelValidator>()));
    services.registerFactory(() => ResidenceUpdateCubit(residencesRepository: residencesRepository, modelValidator: services.get<ResidenceUpdateRequestModelValidator>()));
    services.registerFactory(() => ResidentStatusUpdateCubit(residentsRepository: residentsRepository));
    services.registerFactory(() => ResidentAddCubit(residentsRepository: residentsRepository, modelValidator: services.get<ResidentAddRequestModelValidator>()));
    services.registerFactory(() => PaymentAddCubit(paymentsRepository: paymentsRepository));
    services.registerFactory(() => ChatGroupsCubit(chatsRepository: chatsRepository));
    services.registerFactory(() => ChatMessagesCubit(chatsRepository: chatsRepository));
    services.registerFactory(() => ChatMessageAddCubit(chatsRepository: chatsRepository));
  }
}
