import 'package:rrms/_all.dart';

class ProfileUpdateCubit extends EventProviderCubit<ProfileUpdateState> {
  final AccountRepository accountRepository;

  ProfileUpdateCubit({
    required this.accountRepository,
    required AccountUpdateRequestModelValidator modelValidator,
  }) : super(ProfileUpdateState.initial(modelValidator));

  Future<void> init() async {
    emit(state.copyWith(status: ProfileUpdateStateStatus.initializing));

    final result = await accountRepository.prepareForUpdate();

    if (result.isSuccess) {
      emit(state.copyWith(status: ProfileUpdateStateStatus.initialized, model: result.data));
    }
  }

  Future<void> update(AccountUpdateRequestModel? model) async {
    emit(state.copyWith(model: model));
  }

  Future<void> submit() async {
    final isModelValid = state.modelValidator.validate(state.model);

    if (isModelValid) {
      emit(state.copyWith(status: ProfileUpdateStateStatus.submitting));

      final result = await accountRepository.update(state.model!);

      if (result.isSuccess) {
        emit(state.copyWith(status: ProfileUpdateStateStatus.submittingSuccess));
      } else {
        emit(state.copyWith(status: ProfileUpdateStateStatus.submittingError));
      }
    } else {
      emit(state.copyWith(status: ProfileUpdateStateStatus.validationError));
      emit(state.copyWith(status: ProfileUpdateStateStatus.initialSubmitted));
    }
  }
}
