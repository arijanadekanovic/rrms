import 'package:rrms/_all.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    if (environment.isDevelopment) {
      const colorCode = '\x1B[33m';

      final blocName = _clean(bloc.runtimeType);
      final eventName = _clean(transition.event);

      debugPrint('$colorCode [$blocName] -> $eventName -> $colorCode');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final blocName = _clean(bloc.runtimeType);
    logger.debug('Bloc error: [$blocName] $error, $stackTrace)');

    super.onError(bloc, error, stackTrace);
  }

  String _clean(dynamic text) => text.toString().replaceAll('\'', '').replaceAll('Instance of ', '');
}
