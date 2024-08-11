import 'package:rrms/_all.dart';

class SignInCubit extends EventProviderCubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit({
    required this.authRepository,
    required SignInRequestModelValidator modelValidator,
  }) : super(SignInState.initial(modelValidator));

  void update(SignInRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    final isModelValid = state.modelValidator.validate(state.model);

    if (isModelValid) {
      emit(state.copyWith(status: SignInStateStatus.submitting));

      final result = await authRepository.signIn(state.model);

      if (result.isSuccess) {
        emit(state.copyWith(status: SignInStateStatus.submittingSuccess));
      } else {
        emit(state.copyWith(status: SignInStateStatus.submittingError));
      }
    } else {
      emit(state.copyWith(status: SignInStateStatus.validationError));
      emit(state.copyWith(status: SignInStateStatus.initial));
    }
  }
}
