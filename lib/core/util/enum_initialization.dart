abstract class Enum<T> {
  final T _value;

  const Enum(this._value);

  T get value => _value;
}

class CachingKey extends Enum<String> {
  const CachingKey(super.val);

  static const CachingKey token = CachingKey('token');
  static const CachingKey refreshToken = CachingKey('refreshToken');
}
