extension ListX<T> on List<T> {
  T? firstOrDefault([bool Function(T element)? test]) {
    if (test != null) {
      try {
        return firstWhere(test);
      } catch (e) {
        return null;
      }
    } else {
      try {
        return firstWhere((T element) => true);
      } catch (e) {
        return null;
      }
    }
  }
}
