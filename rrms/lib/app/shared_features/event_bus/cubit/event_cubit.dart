import 'package:rrms/_all.dart';

abstract class EventProviderCubit<S> extends Cubit<S> {
  StreamSubscription? _stateStreamSubscription;

  EventProviderCubit(super.initialState) {
    _stateStreamSubscription = stream.attachToEventBus();
  }

  @override
  Future<void> close() async {
    _stateStreamSubscription?.cancel();

    super.close();
  }
}

abstract class EventReaderCubit<S> extends Cubit<S> {
  StreamSubscription? _eventBusStreamSubscription;

  EventReaderCubit(super.initialState) {
    _eventBusStreamSubscription = eventBus.stream.listen(onEvent);
  }

  void onEvent(Object event);

  @override
  Future<void> close() async {
    _eventBusStreamSubscription?.cancel();

    super.close();
  }
}

abstract class EventCubit<S> extends Cubit<S> {
  StreamSubscription? _stateStreamSubscription;
  StreamSubscription? _eventBusStreamSubscription;

  EventCubit(super.initialState) {
    _stateStreamSubscription = stream.attachToEventBus();
    _eventBusStreamSubscription = eventBus.stream.listen(onEvent);
  }

  void onEvent(Object event);

  @override
  Future<void> close() async {
    _stateStreamSubscription?.cancel();
    _eventBusStreamSubscription?.cancel();

    super.close();
  }
}
