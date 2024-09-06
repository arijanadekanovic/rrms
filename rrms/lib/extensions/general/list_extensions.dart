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
}

extension AppListExtensions<T> on List<T>? {
  int get count => this == null ? 0 : this!.length;
}
