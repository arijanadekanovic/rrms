import 'package:rrms/_all.dart';

ThemeData appThemeLargeLight() => appThemeLargeBase(_appThemeData());

AppThemeData _appThemeData() {
  return AppThemeData(
    primaryColor: const Color(0xFF03254c),
    accentColor: const Color(0xFFf38b72),
    success: const Color(0xFF16A34A),
    successLight: const Color(0xFF04B440),
    warning: const Color(0xFFF6C000),
    danger: const Color(0xFFDC2626),
    separator: const Color(0xFFF1F5F9),
    separatorDark: const Color(0xFF94A3B8),
    cardBackgroundColor: Color(0xFFf5f5f5),
    shimmerHighlightColor: const Color(0xFFf1f5f9),
    actionBackgroundColor: const Color(0xFFF1F5F9),
    surfaceBackgroundColor: Colors.white,
    invertedSurfaceBackgroundColor: const Color(0xFF0f1014),
    bottomSheetListTileBackgroundColor: const Color(0xFFeaebed),
    neutral: const Color(0xFFCBD5E1),
    neutralLight: const Color(0xFFF9F9F9),
    yellow: const Color(0xFFFFC700),
    orange: const Color(0xFFF69B11),
    purple: const Color(0xFF7239EA),
    blue: const Color(0xFF3E97FF),
    inputLabelColor: Color(0xFF020617),
    inputHintColor: Color(0xFF64748B),
    inputFillColor: const Color(0xFFFFFFFF),
    inputBorderColor: Color(0xFFD7DCE3),
    purpleGradient: const [Color(0xFF252F4A), Color(0xFF7239EA)],
    orangeGradient: const [Color(0xFFF69B11), Color(0xFFFFC700)],
    primaryTextStyle: AppTextStyle(
      baseTextStyle: TextStyle(fontFamily: 'WorkSans', color: Color(0xFF020617)),
      color: Color(0xFF020617),
    ),
    secondaryTextStyle: AppTextStyle(
      baseTextStyle: TextStyle(fontFamily: 'WorkSans', color: Color(0xFF64748B)),
      color: Color(0xFF64748B),
    ),
    accentTextStyle: AppTextStyle(
      baseTextStyle: TextStyle(fontFamily: 'WorkSans', color: Colors.red),
      color: Colors.red,
    ),
  );
}
