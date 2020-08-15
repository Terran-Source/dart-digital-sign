part of marganam.cipher;

class Bytes {
  final Uint8List _bytes;

  Bytes(this._bytes) {
    ArgumentError.checkNotNull(_bytes, 'bytes');
  }

  Bytes.random([int length = 16]) : _bytes = randomBytes(length);

  Bytes.timedRandom([int length = 32])
      : assert(length >= 32),
        _bytes = timedRandomBytes(length);

  Bytes.fromString(String value)
      : assert(value?.isNotEmpty ?? false),
        _bytes = value.encodedBytes();

  Uint8List get extract => _bytes;

  @override
  int get hashCode => _bytes.hash();

  @override
  bool operator ==(check) => check is Bytes && _bytes.equals(check._bytes);

  @override
  String toString() => _bytes.encodedString();
}
