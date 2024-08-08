import 'package:rrms/_all.dart';

ThemeData appThemeLargeBase(AppThemeData appTheme) {
  return ThemeData(
    extensions: [appTheme],
    primaryColor: appTheme.primaryColor,
    colorScheme: ColorScheme.light(
      primary: appTheme.primaryColor,
      surfaceTint: appTheme.surfaceBackgroundColor,
      surface: appTheme.surfaceBackgroundColor,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(appTheme.primaryColor),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appTheme.primaryColor,
      selectionColor: appTheme.primaryColor.withOpacity(0.5),
      selectionHandleColor: appTheme.primaryColor,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
        surfaceTintColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
      ),
      inputDecorationTheme: getInputDecorationTheme(appTheme),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(appTheme.actionBackgroundColor),
      trackColor: WidgetStateProperty.all(appTheme.actionBackgroundColor),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      thumbIcon: WidgetStateProperty.all(Icon(Icons.circle, size: 26, color: appTheme.surfaceBackgroundColor)),
    ),
    iconTheme: IconThemeData(
      weight: 400,
      color: appTheme.secondaryTextStyle.color,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appTheme.surfaceBackgroundColor,
      surfaceTintColor: appTheme.surfaceBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    menuButtonTheme: MenuButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
        iconColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
        side: WidgetStateProperty.all(BorderSide.none),
        textStyle: WidgetStateProperty.all(appTheme.primaryTextStyle.t14500),
      ),
    ),
    menuTheme: MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
    menuBarTheme: MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
    timePickerTheme: () {
      final textColor = appTheme.accentColor;
      final contentColor = appTheme.surfaceBackgroundColor;
      final backgroundColor = appTheme.surfaceBackgroundColor;

      return TimePickerThemeData(
        backgroundColor: backgroundColor,
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(textColor),
          textStyle: WidgetStateProperty.all(appTheme.primaryTextStyle.t14500),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(textColor),
          textStyle: WidgetStateProperty.all(appTheme.primaryTextStyle.t14600),
        ),
        dayPeriodBorderSide: BorderSide(color: textColor),
        dayPeriodColor: appTheme.neutral,
        dayPeriodTextColor: textColor,
        dialBackgroundColor: contentColor,
        dialHandColor: appTheme.neutral,
        dialTextColor: textColor,
        entryModeIconColor: textColor,
        hourMinuteColor: contentColor,
        hourMinuteTextColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      );
    }(),
    datePickerTheme: () {
      final primaryColor = appTheme.primaryColor;
      final primaryMaterialColor = WidgetStatePropertyAll(primaryColor);

      return DatePickerThemeData(
        backgroundColor: appTheme.surfaceBackgroundColor,
        surfaceTintColor: appTheme.surfaceBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        todayBorder: BorderSide(color: primaryColor),
        rangeSelectionBackgroundColor: primaryColor,
        rangeSelectionOverlayColor: primaryMaterialColor,
      );
    }(),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: appTheme.primaryTextStyle.color,
      ),
    ),
    scaffoldBackgroundColor: appTheme.surfaceBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: appTheme.primaryColor,
      surfaceTintColor: appTheme.primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appTheme.primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: appTheme.accentColor,
      selectedIconTheme: IconThemeData(weight: 700),
      unselectedIconTheme: IconThemeData(weight: 700, color: Colors.blue),
    ),
    cardColor: appTheme.cardBackgroundColor,
    cardTheme: CardTheme(color: appTheme.cardBackgroundColor),
    listTileTheme: const ListTileThemeData(
      horizontalTitleGap: 0.0,
      contentPadding: EdgeInsets.zero,
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      side: BorderSide(width: 2.0, color: appTheme.accentColor),
      checkColor: WidgetStateProperty.all(appTheme.surfaceBackgroundColor),
      fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? appTheme.accentColor : Colors.transparent),
    ),
    dialogBackgroundColor: appTheme.surfaceBackgroundColor,
    dialogTheme: DialogTheme(
      backgroundColor: appTheme.surfaceBackgroundColor,
      surfaceTintColor: appTheme.surfaceBackgroundColor,
      contentTextStyle: appTheme.accentTextStyle.baseTextStyle,
    ),
    inputDecorationTheme: getInputDecorationTheme(appTheme),
  );
}

InputDecorationTheme getInputDecorationTheme(AppThemeData appTheme) {
  return InputDecorationTheme(
    labelStyle: TextStyle(
      color: appTheme.inputLabelColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: appTheme.inputLabelColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: appTheme.inputHintColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    prefixStyle: TextStyle(
      color: appTheme.secondaryTextStyle.color,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: appTheme.secondaryTextStyle.color,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: appTheme.inputLabelColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    isCollapsed: false,
    filled: false,
    fillColor: appTheme.inputFillColor,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.accentColor, width: 1, style: BorderStyle.solid),
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.inputBorderColor, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.inputBorderColor, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.inputBorderColor, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.inputBorderColor, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
  );
}
