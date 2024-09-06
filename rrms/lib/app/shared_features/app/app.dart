import 'package:rrms/_all.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppProviders(
      child: AnimatedFadeIn(
        child: _AppLayoutBuilder(),
      ),
    );
  }
}

class _AppLayoutBuilder extends StatelessWidget {
  const _AppLayoutBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return ResponsiveLayoutBuilder(
          small: (_, __) => _App(theme: AppTheme.smallLight(), darkTheme: AppTheme.smallDark(), themeMode: themeState.mode),
          medium: (_, __) => _App(theme: AppTheme.mediumLight(), darkTheme: AppTheme.mediumDark(), themeMode: themeState.mode),
          large: (_, __) => _App(theme: AppTheme.largeLight(), darkTheme: AppTheme.largeDark(), themeMode: themeState.mode),
        );
      },
    );
  }
}

class _App extends StatelessWidget {
  const _App({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, localizationState) {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();

                return true;
              },
              child: MaterialApp.router(
                title: appSettings.appName,
                theme: theme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                locale: localizationState.language.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                scaffoldMessengerKey: scaffoldMessengerKey,
                builder: (context, child) {
                  translations = AppLocalizations.of(context);

                  setStatusBarAndSystemNavigationColors(
                    statusBarColor: context.theme.appBarTheme.backgroundColor,
                    systemNavigationBarColor: context.theme.bottomNavigationBarTheme.backgroundColor,
                  );
                  FlutterNativeSplash.remove();

                  return ErrorHandlerAppWidgetListener(
                    child: DismissFocusOverlay(
                      child: PushNotificationsAppWidgetListener(
                          child: child!,
                        ),
                    ),
                  );
                },
                routerConfig: appRouter,
              ),
            );
          },
        );
      },
    );
  }
}

void setStatusBarAndSystemNavigationColors({
  Color? statusBarColor = Colors.white,
  Color? systemNavigationBarColor = Colors.white,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
    ),
  );

  // logger.info('SYSTEM NAVIGATION COLOR CHANGED: STATUS BAR($statusBarColor) | NAVIGATION BAR($systemNavigationBarColor)');
}

Future<void> setOrientationPortrait() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> setOrientationLandscape() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

Future<void> setOrientationRotation() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}
