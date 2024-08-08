import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rrms/_all.dart';

Logger get logger => services.get<Logger>();

abstract class Logger {
  Future<void> error(String message);
  Future<void> event(String eventName);
  Future<void> debug(String message);
}

class ConsoleLoggerImpl implements Logger {
  @override
  Future<void> error(String message) async => log('[ERROR]: $message');

  @override
  Future<void> event(String eventName) async => log('[EVENT]: $eventName');

  @override
  Future<void> debug(String message) async {
    if (kDebugMode) {
      log('[DEV INFO]: $message');
    }
  }
}
