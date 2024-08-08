import 'package:rrms/_all.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ConfigRepository configRepository;

  ThemeCubit({
    required this.configRepository,
  }) : super(ThemeState.initial()) {
    init();
  }

  Future<void> init() async {
    final mode = await configRepository.getThemeMode();

    emit(state.copyWith(status: ThemeStateStatus.initialized, mode: mode));
  }

  Future<void> change(ThemeMode mode) async {
    await configRepository.setThemeMode(mode);

    emit(state.copyWith(mode: mode));
  }

  Future<void> toggleDarkMode() async {
    change(state.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
