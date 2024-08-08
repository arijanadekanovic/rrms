import 'package:rrms/_all.dart';

enum ThemeStateStatus {
  initializing,
  initialized,
}

class ThemeState {
  ThemeStateStatus status;
  ThemeMode mode;

  bool get isDarkMode => mode == ThemeMode.dark;

  ThemeState({
    required this.status,
    required this.mode,
  });

  factory ThemeState.initial() {
    return ThemeState(
      status: ThemeStateStatus.initialized,
      mode: ThemeMode.light,
    );
  }

  ThemeState copyWith({
    ThemeStateStatus? status,
    ThemeMode? mode,
  }) {
    return ThemeState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
    );
  }
}
