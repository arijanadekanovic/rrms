import 'package:rrms/_all.dart';

class AppThemeData implements ThemeExtension<AppThemeData> {
  final Color primaryColor;
  final Color accentColor;
  final Color success;
  final Color successLight;
  final Color warning;
  final Color danger;
  final Color separator;
  final Color separatorDark;
  final Color cardBackgroundColor;
  final Color shimmerHighlightColor;
  final Color actionBackgroundColor;
  final Color surfaceBackgroundColor;
  final Color invertedSurfaceBackgroundColor;
  final Color bottomSheetListTileBackgroundColor;
  final Color neutral;
  final Color neutralLight;
  final Color orange;
  final Color yellow;
  final Color purple;
  final Color blue;
  final Color inputLabelColor;
  final Color inputHintColor;
  final Color inputFillColor;
  final Color inputBorderColor;
  final List<Color> purpleGradient;
  final List<Color> orangeGradient;
  final AppTextStyle primaryTextStyle;
  final AppTextStyle secondaryTextStyle;
  final AppTextStyle accentTextStyle;

  AppThemeData({
    required this.primaryColor,
    required this.accentColor,
    required this.success,
    required this.successLight,
    required this.warning,
    required this.danger,
    required this.separator,
    required this.separatorDark,
    required this.cardBackgroundColor,
    required this.shimmerHighlightColor,
    required this.actionBackgroundColor,
    required this.surfaceBackgroundColor,
    required this.invertedSurfaceBackgroundColor,
    required this.bottomSheetListTileBackgroundColor,
    required this.neutral,
    required this.neutralLight,
    required this.orange,
    required this.yellow,
    required this.purple,
    required this.blue,
    required this.inputLabelColor,
    required this.inputHintColor,
    required this.inputFillColor,
    required this.inputBorderColor,
    required this.purpleGradient,
    required this.orangeGradient,
    required this.primaryTextStyle,
    required this.secondaryTextStyle,
    required this.accentTextStyle,
  });

  @override
  ThemeExtension<AppThemeData> copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? success,
    Color? successLight,
    Color? warning,
    Color? danger,
    Color? separator,
    Color? separatorDark,
    Color? cardBackgroundColor,
    Color? shimmerHighlightColor,
    Color? actionBackgroundColor,
    Color? surfaceBackgroundColor,
    Color? invertedSurfaceBackgroundColor,
    Color? bottomSheetListTileBackgroundColor,
    Color? neutral,
    Color? neutralLight,
    Color? orange,
    Color? yellow,
    Color? purple,
    Color? blue,
    Color? inputLabelColor,
    Color? inputHintColor,
    Color? inputFillColor,
    Color? inputBorderColor,
    List<Color>? purpleGradient,
    List<Color>? orangeGradient,
    AppTextStyle? primaryTextStyle,
    AppTextStyle? secondaryTextStyle,
    AppTextStyle? accentTextStyle,
    Color? scaffoldBackgroundColor,
  }) {
    return AppThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      separator: separator ?? this.separator,
      separatorDark: separatorDark ?? this.separatorDark,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      shimmerHighlightColor: shimmerHighlightColor ?? this.shimmerHighlightColor,
      actionBackgroundColor: actionBackgroundColor ?? this.actionBackgroundColor,
      surfaceBackgroundColor: surfaceBackgroundColor ?? this.surfaceBackgroundColor,
      invertedSurfaceBackgroundColor: invertedSurfaceBackgroundColor ?? this.invertedSurfaceBackgroundColor,
      bottomSheetListTileBackgroundColor: bottomSheetListTileBackgroundColor ?? this.bottomSheetListTileBackgroundColor,
      neutral: neutral ?? this.neutral,
      neutralLight: neutralLight ?? this.neutralLight,
      orange: orange ?? this.orange,
      yellow: yellow ?? this.yellow,
      purple: purple ?? this.purple,
      blue: blue ?? this.blue,
      inputLabelColor: inputLabelColor ?? this.inputLabelColor,
      inputHintColor: inputHintColor ?? this.inputHintColor,
      inputFillColor: inputFillColor ?? this.inputFillColor,
      inputBorderColor: inputBorderColor ?? this.inputBorderColor,
      purpleGradient: purpleGradient ?? this.purpleGradient,
      orangeGradient: orangeGradient ?? this.orangeGradient,
      primaryTextStyle: primaryTextStyle ?? this.primaryTextStyle,
      secondaryTextStyle: secondaryTextStyle ?? this.secondaryTextStyle,
      accentTextStyle: accentTextStyle ?? this.accentTextStyle,
    );
  }

  @override
  ThemeExtension<AppThemeData> lerp(ThemeExtension<AppThemeData>? other, double t) {
    if (other is! AppThemeData) {
      return this;
    }

    return AppThemeData(
      primaryColor: other.primaryColor,
      accentColor: other.accentColor,
      success: other.success,
      successLight: other.successLight,
      warning: other.warning,
      danger: other.danger,
      separator: other.separator,
      separatorDark: other.separatorDark,
      cardBackgroundColor: other.cardBackgroundColor,
      shimmerHighlightColor: other.shimmerHighlightColor,
      actionBackgroundColor: other.actionBackgroundColor,
      surfaceBackgroundColor: other.surfaceBackgroundColor,
      invertedSurfaceBackgroundColor: other.invertedSurfaceBackgroundColor,
      bottomSheetListTileBackgroundColor: other.bottomSheetListTileBackgroundColor,
      neutral: other.neutral,
      neutralLight: other.neutralLight,
      orange: other.orange,
      yellow: other.yellow,
      purple: other.purple,
      blue: other.blue,
      inputLabelColor: other.inputLabelColor,
      inputHintColor: other.inputHintColor,
      inputFillColor: other.inputFillColor,
      inputBorderColor: other.inputBorderColor,
      purpleGradient: other.purpleGradient,
      orangeGradient: other.orangeGradient,
      primaryTextStyle: other.primaryTextStyle,
      secondaryTextStyle: other.secondaryTextStyle,
      accentTextStyle: other.accentTextStyle,
    );
  }

  @override
  Object get type => AppThemeData;
}
