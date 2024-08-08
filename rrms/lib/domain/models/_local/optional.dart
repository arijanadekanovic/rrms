class Optional<T> {
  final T? _value;
  T? get value => _value;

  Optional(T? value) : _value = value;

  const Optional.absent() : _value = null;
}
