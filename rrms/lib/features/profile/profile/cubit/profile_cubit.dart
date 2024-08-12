import 'package:rrms/_all.dart';

class ProfileCubit extends EventReaderCubit<ProfileState> {
  final AccountRepository accountRepository;

  ProfileCubit({
    required this.accountRepository,
  }) : super(ProfileState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStateStatus.loading));

    final result = await accountRepository.getAccountDetails();

    if (result.isSuccess) {
      emit(
        state.copyWith(
          status: ProfileStateStatus.loaded,
          accountDetails: result.data,
        ),
      );
    }
  }

  @override
  void onEvent(Object event) {
    if (event is AuthState && event.isAuthenticated) load();
    if (event is ProfileUpdateState && event.status == ProfileUpdateStateStatus.submittingSuccess) load();
  }
}
