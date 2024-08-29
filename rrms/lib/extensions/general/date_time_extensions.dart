import 'package:intl/intl.dart';

import 'package:rrms/_all.dart';

extension DateTimeExtensions on DateTime? {
  String format([String pattern = 'dd.MM.yyyy']) => this != null ? DateFormat(pattern).format(this!).toString() : '';

  String formattimehmma() => this != null ? DateFormat('HH:mm', translations.localeName).format(this!).toString() : '';

  String formatDateTime([String pattern = 'dd.MM.yyyy', String connectionWord = '']) => this != null ? '${format(pattern)} ${connectionWord.isNotNullOrEmpty ? '$connectionWord ' : ''}${formattimehmma()}' : '';

  DateTime get valueOrNow => this ?? DateTime.now();

  bool get isToday {
    if (this == null) {
      return false;
    }

    final now = DateTime.now();

    return this!.year == now.year && this!.month == now.month && this!.day == now.day;
  }

  String? toJson() {
    return this != null ? '${_pad(this!.year)}-${_pad(this!.month)}-${_pad(this!.day)}T${_pad(this!.hour)}:${_pad(this!.minute)}:${_pad(this!.second)}' : null;
  }

  String? toJsonDate() {
    return this != null ? '${_pad(this!.year)}-${_pad(this!.month)}-${_pad(this!.day)}' : null;
  }

  String _pad(int value) => value.toString().padLeft(2, '0');

  DateTimePeriodModel get period {
    final currentDateTime = DateTime.now();
    final currentDate = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day);

    final thisDateTime = this!;
    final thisDate = DateTime(thisDateTime.year, thisDateTime.month, thisDateTime.day);

    final differenceInDays = thisDate.difference(currentDate).inDays;
    final differenceInHours = thisDateTime.difference(currentDateTime).inHours;
    final differenceInMinutes = thisDateTime.difference(currentDateTime).inMinutes;
    final differenceInSeconds = thisDateTime.difference(currentDateTime).inSeconds;

    if (differenceInDays < -13) return DateTimePeriodModel(period: DateTimePeriod.general);
    if (differenceInDays < -6) return DateTimePeriodModel(period: DateTimePeriod.lastWeek);
    if (differenceInDays.between(-6, -2)) return DateTimePeriodModel(period: DateTimePeriod.beforeFewDays, amount: differenceInDays.abs());
    if (differenceInDays == -1) return DateTimePeriodModel(period: DateTimePeriod.yesterday);

    if (differenceInDays == 0 && differenceInHours < 0) return DateTimePeriodModel(period: DateTimePeriod.beforeFewHours, amount: differenceInHours.abs());

    if (differenceInDays == 0 && differenceInHours == 0 && differenceInMinutes < 0) return DateTimePeriodModel(period: DateTimePeriod.beforeFewMinutes, amount: differenceInMinutes.abs());

    if (differenceInDays == 0 && differenceInHours == 0 && differenceInMinutes == 0 && differenceInSeconds < 0) return DateTimePeriodModel(period: DateTimePeriod.beforeFewSeconds, amount: differenceInSeconds.abs());
    if (differenceInDays == 0 && differenceInHours == 0 && differenceInMinutes == 0 && differenceInSeconds == 0) return DateTimePeriodModel(period: DateTimePeriod.now);
    if (differenceInDays == 0 && differenceInHours == 0 && differenceInMinutes == 0 && differenceInSeconds > 0) return DateTimePeriodModel(period: DateTimePeriod.afterFewSeconds, amount: differenceInSeconds);

    if (differenceInDays == 0 && differenceInHours == 0 && differenceInMinutes > 0) return DateTimePeriodModel(period: DateTimePeriod.afterFewMinutes, amount: differenceInMinutes);

    if (differenceInDays == 0 && differenceInHours > 0) return DateTimePeriodModel(period: DateTimePeriod.afterFewHours, amount: differenceInHours);

    if (differenceInDays == 1) return DateTimePeriodModel(period: DateTimePeriod.tommorow);
    if (differenceInDays.between(2, 6)) return DateTimePeriodModel(period: DateTimePeriod.afterFewDays, amount: differenceInDays);
    if (differenceInDays > 6) return DateTimePeriodModel(period: DateTimePeriod.nextWeek);
    if (differenceInDays > 13) return DateTimePeriodModel(period: DateTimePeriod.general);

    return DateTimePeriodModel(period: DateTimePeriod.general);
  }
}

enum DateTimePeriod {
  lastWeek,
  beforeFewDays,
  yesterday,
  beforeFewHours,
  beforeFewMinutes,
  beforeFewSeconds,
  now,
  afterFewSeconds,
  afterFewMinutes,
  afterFewHours,
  tommorow,
  afterFewDays,
  nextWeek,
  general;
}

class DateTimePeriodModel {
  final DateTimePeriod period;
  final int amount;

  DateTimePeriodModel({
    required this.period,
    this.amount = 0,
  });
}
