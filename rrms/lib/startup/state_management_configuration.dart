import 'package:rrms/_all.dart';
import 'package:rrms/features/payments/payments/cubits/_all.dart';

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

    services.registerSingleton<IEventBus>(EventBus());

    services.registerSingleton(ConnectivityCubit());
    services.registerSingleton(ErrorHandlerCubit(restApiClient: restApiClient));
    services.registerSingleton(LocalizationCubit(restApiClient: restApiClient, configRepository: configRepository));
    services.registerSingleton(ThemeCubit(configRepository: configRepository));

    services.registerSingleton(AuthCubit(restApiClient: restApiClient, authRepository: authRepository));
    services.registerSingleton(SignOutCubit(authRepository: authRepository));

    services.registerSingleton(ProfileCubit(accountRepository: accountRepository));
    services.registerSingleton(CitiesCubit(citiesRepository: citiesRepository));
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
    services.registerFactoryParam((bool? isVisible, _) => VisibilityCubit(isVisible: isVisible.value));
    services.registerFactoryParam((Permission permission, _) => PermissionHandlerCubit(permission: permission));
    services.registerFactoryParam((String url, _) => AppPdfViewerCubit(url: url));

    services.registerFactory(() => ResidenceDetailsCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidenceDeleteCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidencesCubit(residencesRepository: residencesRepository));
    services.registerFactory(() => ResidentsCubit(residentsRepository: residentsRepository));
    services.registerFactory(() => NotificationsCubit(notificationsRepository: notificationsRepository));
    services.registerFactory(() => PaymentsCubit(paymentsRepository: paymentsRepository));
    services.registerFactory(() => SignInCubit(authRepository: authRepository, modelValidator: services.get<SignInRequestModelValidator>()));
    services.registerFactory(() => SignUpCubit(accountRepository: accountRepository, modelValidator: services.get<SignUpRequestModelValidator>()));
    services.registerFactory(() => ResidenceAddCubit(residencesRepository: residencesRepository, modelValidator: services.get<ResidenceAddRequestModelValidator>()));
    services.registerFactory(() => ProfileUpdateCubit(accountRepository: accountRepository, modelValidator: services.get<AccountUpdateRequestModelValidator>()));
    services.registerFactory(() => ResidenceUpdateCubit(residencesRepository: residencesRepository, modelValidator: services.get<ResidenceUpdateRequestModelValidator>()));
    services.registerFactory(() => ResidentStatusUpdateCubit(residentsRepository: residentsRepository));
    services.registerFactory(() => ResidentAddCubit(residentsRepository: residentsRepository, modelValidator: services.get<ResidentAddRequestModelValidator>()));
    services.registerFactory(() => ChatGroupsCubit(chatsRepository: chatsRepository));
  }
}
