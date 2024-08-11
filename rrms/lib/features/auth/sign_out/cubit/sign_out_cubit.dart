import 'package:rrms/_all.dart';

class SignOutCubit extends EventProviderCubit<SignOutState> {
  final AuthRepository authRepository;

  SignOutCubit({
    required this.authRepository,
  }) : super(SignOutState.initial());

  Future<void> submit() async {
    emit(state.copyWith(status: SignOutStateStatus.submitting));

    final result = await authRepository.signOut();

    if (result.isSuccess) {
      emit(state.copyWith(status: SignOutStateStatus.submittingSuccess));
    }

    emit(state.copyWith(status: SignOutStateStatus.initial));
  }
}
