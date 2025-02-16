import 'package:rrms/_all.dart';

class UsersCubit extends EventReaderCubit<UsersState> {
  final UsersRepository usersRepository;

  UsersCubit({
    required this.usersRepository,
  }) : super(UsersState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: UsersStateStatus.loading));

    final result = await usersRepository.get();

    emit(
      state.copyWith(
        status: UsersStateStatus.loaded,
        users: result.data,
      ),
    );
  }

  @override
  void onEvent(Object event) {
    if (event is AuthState && event.isAuthenticated) load();
  }
}
