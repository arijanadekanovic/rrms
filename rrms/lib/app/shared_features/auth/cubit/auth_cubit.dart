import 'package:rrms/_all.dart';

class AuthCubit extends EventCubit<AuthState> {
  final AuthRepository authRepository;

  StreamSubscription? _restApiClientSubscription;

  AuthCubit({
    required this.authRepository,
    required RestApiClient restApiClient,
  }) : super(AuthState.initial()) {
    _restApiClientSubscription = restApiClient.exceptionHandler.exceptions.stream.listen((exception) {
      if (exception is UnauthorizedException) {
        update(AuthStateStatus.unAuthenticated);
      }
    });

    check();
  }

  void update(AuthStateStatus status) => emit(state.copyWith(status: status));

  Future<void> check() async {
    final isAuthenticated = await authRepository.isAuthenticated();

    emit(
      state.copyWith(
        status: isAuthenticated ? AuthStateStatus.authenticated : AuthStateStatus.unAuthenticated,
      ),
    );
  }

  @override
  void onEvent(Object event) {
    if (event is SignInState && event.status == SignInStateStatus.submittingSuccess) check();
    if (event is SignOutState && event.status == SignOutStateStatus.submittingSuccess) check();
  }

  @override
  Future<void> close() {
    _restApiClientSubscription?.cancel();

    return super.close();
  }
}
