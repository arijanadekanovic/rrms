import 'package:rrms/_all.dart';

class PushNotificationsCubit extends EventProviderCubit<PushNotificationsState> {
  final PushNotificationsService pushNotificationsService;

  StreamSubscription? _pushNotificationsSubscription;

  PushNotificationsCubit({
    required this.pushNotificationsService,
  }) : super(PushNotificationsState.initial()) {
    _pushNotificationsSubscription = pushNotificationsService.pushNotifications.stream.listen(
      (notification) => add(notification),
    );

    init();
  }

  Future<void> init() async => await pushNotificationsService.init();

  Future<void> add(PushNotificationModel notification) async {
    state.items.add(notification);

    emit(state.copyWith());
  }

  @override
  Future<void> close() {
    _pushNotificationsSubscription?.cancel();

    return super.close();
  }
}
