import 'package:flutter/foundation.dart';
import 'package:rrms/_all.dart';

abstract class AppLanguages {
  static final List<LanguageModel> values = [
    LanguageModel(
      code: 'en',
      shortName: 'ENG',
      name: 'English',
    ),
  ];

  static LanguageModel get initial {
    return _tryGetBySystemLanguage() ??
        values.firstWhere(
          (x) => x.locale.languageCode == (environment.isProduction && !kDebugMode ? 'de' : 'en'),
        );
  }

  static LanguageModel? _tryGetBySystemLanguage() {
    try {
      final platformLocale = Locale(Platform.localeName.substring(0, 2));

      return values.firstWhere((x) => x.locale.languageCode == platformLocale.languageCode);
    } catch (e) {
      logger.debug(e.toString());

      return null;
    }
  }
}
