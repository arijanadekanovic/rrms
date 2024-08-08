import 'package:rrms/_all.dart';

enum LocalizationStateStatus {
  initializing,
  initialized,
  changed,
}

class LocalizationState {
  LocalizationStateStatus status;
  LanguageModel language;
  bool languagePreviouslySelected;

  LocalizationState({
    required this.status,
    required this.language,
    this.languagePreviouslySelected = false,
  });

  factory LocalizationState.initial() => LocalizationState(
        status: LocalizationStateStatus.initializing,
        language: AppLanguages.values.first,
      );

  LocalizationState copyWith({
    LocalizationStateStatus? status,
    LanguageModel? language,
    bool? languagePreviouslySelected,
  }) =>
      LocalizationState(
        status: status ?? this.status,
        language: language ?? this.language,
        languagePreviouslySelected: languagePreviouslySelected ?? this.languagePreviouslySelected,
      );
}
