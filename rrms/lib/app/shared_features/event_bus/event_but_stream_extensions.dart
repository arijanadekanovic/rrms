import 'package:rrms/_all.dart';

extension EventBusStreamExtensions on Stream {
  StreamSubscription attachToEventBus() => where((event) => event is Event).listen(
        (event) => eventBus.send((event as Event).copyWith()),
      );
}
