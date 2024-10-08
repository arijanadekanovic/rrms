import 'package:easy_debounce/easy_debounce.dart';
import 'package:rrms/_all.dart';

Debouncer get debouncer => services.get<Debouncer>();

abstract class Debouncer {
  void debounce(
    void Function() onExecute, {
    Duration duration,
    String tag,
  });
}

class DebouncerImpl implements Debouncer {
  @override
  void debounce(
    void Function() onExecute, {
    Duration duration = const Duration(milliseconds: 1500),
    String tag = 'common-debouncer',
  }) {
    EasyDebounce.debounce(
      tag,
      duration,
      onExecute,
    );
  }
}
