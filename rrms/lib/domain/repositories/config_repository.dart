import 'package:rrms/_all.dart';

abstract class ConfigRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);
  Future<LanguageModel> getLanguage();
  Future<void> setLanguage(String languageCode);
}

class ConfigRepositoryImpl implements ConfigRepository {
  final StorageRepository storageRepository;
  final RestApiClient restApiClient;

  ConfigRepositoryImpl({
    required this.storageRepository,
    required this.restApiClient,
  });

  @override
  Future<ThemeMode> getThemeMode() async {
    int? themeModeIndex = await storageRepository.get(AppKeys.theme_mode);

    return themeModeIndex != null ? ThemeMode.values[themeModeIndex] : ThemeMode.light;
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async => await storageRepository.set(AppKeys.theme_mode, mode.index);

  @override
  Future<LanguageModel> getLanguage() async {
    String? languageCode = await storageRepository.get(AppKeys.language_code);

    return AppLanguages.values.firstOrDefault((x) => x.locale.languageCode == languageCode) ?? AppLanguages.initial;
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await storageRepository.set(AppKeys.language_code, languageCode);
  }
}
