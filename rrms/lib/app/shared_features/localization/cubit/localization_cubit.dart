import 'package:rrms/_all.dart';
import 'package:intl/intl.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final RestApiClient restApiClient;
  final ConfigRepository configRepository;

  LocalizationCubit({
    required this.restApiClient,
    required this.configRepository,
  }) : super(LocalizationState.initial()) {
    init();
  }

  Future<void> init() async {
    final language = await configRepository.getLanguage();

    Intl.defaultLocale = language.locale.languageCode;
    restApiClient.setAcceptLanguageHeader(language.locale.languageCode);

    emit(state.copyWith(status: LocalizationStateStatus.initialized, language: language));
  }

  Future<void> change(LanguageModel language) async {
    await configRepository.setLanguage(language.locale.languageCode);

    restApiClient.setAcceptLanguageHeader(language.locale.languageCode);
    Intl.defaultLocale = language.locale.languageCode;

    emit(state.copyWith(status: LocalizationStateStatus.changed, language: language));
    emit(state.copyWith(status: LocalizationStateStatus.initialized));
  }
}
