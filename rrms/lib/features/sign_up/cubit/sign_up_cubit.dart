import 'package:rrms/_all.dart';

class SignUpCubit extends EventProviderCubit<SignUpState> {
  final AccountRepository accountRepository;

  SignUpCubit({
    required this.accountRepository,
    required SignUpRequestModelValidator modelValidator,
  }) : super(SignUpState.initial(modelValidator));

  void update(SignUpRequestModel model) {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    final isModelValid = state.modelValidator.validate(state.model);

    if (isModelValid) {
      emit(state.copyWith(status: SignUpStateStatus.submitting));

      final result = await accountRepository.signUp(state.model);

      if (result.isSuccess) {
        emit(state.copyWith(status: SignUpStateStatus.submittingSuccess));
      } else {
        emit(state.copyWith(status: SignUpStateStatus.submittingError));
      }
    } else {
      emit(state.copyWith(status: SignUpStateStatus.validationError));
      emit(state.copyWith(status: SignUpStateStatus.initialSubmitted));
    }
  }
}
