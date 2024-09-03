import 'package:rrms/_all.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository notificationsRepository;

  NotificationsCubit({
    required this.notificationsRepository,
  }) : super(NotificationsState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: NotificationsStateStatus.loading));

    final result = await notificationsRepository.get();

    emit(
      state.copyWith(
        status: NotificationsStateStatus.loaded,
        notifications: result.data,
      ),
    );
  }
}
