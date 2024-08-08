import 'package:rrms/_all.dart';

extension AppNullableIterableExtensions<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension AppIterableExtensions<T> on Iterable<T> {
  T? firstOrDefault([bool Function(T element)? test, T? defaultElement]) {
    if (test != null) {
      try {
        return firstWhere(test);
      } catch (e) {
        return defaultElement;
      }
    } else {
      try {
        return firstWhere((T element) => true);
      } catch (e) {
        return defaultElement;
      }
    }
  }

  T? lastOrDefault([bool Function(T element)? test, T? defaultElement]) {
    if (test != null) {
      try {
        return lastWhere(test);
      } catch (e) {
        return defaultElement;
      }
    } else {
      try {
        return lastWhere((T element) => true);
      } catch (e) {
        return defaultElement;
      }
    }
  }

  Iterable<U> mapIndexed<U>(U Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in this) {
      yield f(index, item);
      index++;
    }
  }
}

extension AppListExtensions<T> on List<T>? {
  List<T> get value => this ?? [];
  int get count => this == null ? 0 : this!.length;

  T? next([T? element, bool Function(T element)? test, bool loop = true]) {
    if (this?.isNullOrEmpty ?? true) {
      return null;
    }

    T? byIndexOrFirst(int index) => ((index == count - 1) && loop) || !index.between(0, count, endInclusive: false) ? this?.first : this?[index + 1];

    if (element != null) {
      final index = this?.indexOf(element) ?? 0;

      return byIndexOrFirst(index);
    }

    if (test != null) {
      final index = this?.indexWhere(test) ?? 0;

      return byIndexOrFirst(index);
    }

    return this![0];
  }
}

extension AppNullableListExtensions<T> on List<T> {
  List<T> addThen(T element, [bool Function(T element)? test]) {
    final alreadyAdded = test != null ? firstOrDefault(test) != null : contains(element);

    if (!alreadyAdded) {
      add(element);
    }

    return this;
  }

  void replaceWhere(bool Function(T element) test, List<T> replacements) {
    final index = indexWhere(test);

    replaceRange(index, index + 1, replacements);
  }
}
