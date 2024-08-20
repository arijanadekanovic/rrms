import 'package:rrms/_all.dart';

// Register singleton blocs/cubits for the app
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        _<ConnectivityCubit>(),
        _<ErrorHandlerCubit>(),
        _<LocalizationCubit>(),
        _<AuthCubit>(),
        _<SignOutCubit>(),
        _<ThemeCubit>(),
        _<NavigationCubit>(),
        _<ProfileCubit>(),
        _<CitiesCubit>(),
      ],
      child: child,
    );
  }

  BlocProvider<T> _<T extends StateStreamableSource<Object?>>() => BlocProvider<T>.value(value: services.get<T>());
}
