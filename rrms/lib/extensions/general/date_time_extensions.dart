import 'package:intl/intl.dart';

import 'package:rrms/_all.dart';

extension DateTimeExtensions on DateTime? {
  String format([String pattern = 'dd.MM.yyyy']) => this != null ? DateFormat(pattern).format(this!).toString() : '';

  String formattimehmma() => this != null ? DateFormat('HH:mm', translations.localeName).format(this!).toString() : '';

  String formatDateTime([String pattern = 'dd.MM.yyyy', String connectionWord = '']) => this != null ? '${format(pattern)} ${connectionWord.isNotNullOrEmpty ? '$connectionWord ' : ''}${formattimehmma()}' : '';

  String? toJson() => this != null ? '${_pad(this!.year)}-${_pad(this!.month)}-${_pad(this!.day)}T${_pad(this!.hour)}:${_pad(this!.minute)}:${_pad(this!.second)}' : null;

  String _pad(int value) => value.toString().padLeft(2, '0');
}
