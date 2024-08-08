import 'package:rrms/_all.dart';

abstract class IEventBus {
  Stream<Event> get stream;

  void send(Event event);
}

IEventBus get eventBus => services.get<IEventBus>();

class EventBus extends Cubit<Event> implements IEventBus {
  EventBus() : super(InitialEvent());

  @override
  void send(Event event) => emit(event);
}

abstract class Event {
  dynamic copyWith();
}

class InitialEvent implements Event {
  @override
  dynamic copyWith() {}
}
