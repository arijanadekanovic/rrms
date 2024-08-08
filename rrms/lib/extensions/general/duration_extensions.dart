extension DurationX on Duration? {
  String format({bool hours = true, bool minutes = true, bool seconds = true}) {
    final hh = (this?.inHours ?? 0).toString().padLeft(2, '0');
    final mm = ((this?.inMinutes ?? 0) % 60).toString().padLeft(2, '0');
    final ss = ((this?.inSeconds ?? 0) % 60).toString().padLeft(2, '0');

    var result = '';

    if (hours && hh != '00') result += hh;
    if (hours && minutes && mm != '00') result += ':';
    if (minutes || mm != '00') result += mm;
    if (minutes && seconds || mm != '00' || ss != '00') result += ':';
    if (seconds || ss != '00') result += ss;

    return result;
  }

  Duration decreaseBy([double coefficient = 1.0]) {
    final totalSeconds = this?.inSeconds ?? 0;

    return Duration(seconds: (totalSeconds * coefficient).toInt());
  }

  Duration get positiveOrZero => (this?.isNegative ?? false) ? const Duration() : this!;

  double operator /(Duration other) => (this?.inMicroseconds ?? 0) / other.inMicroseconds;
}
