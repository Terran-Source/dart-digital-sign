part of marganam.cipher;

/// General base class for all others (e.g. Nonce, Secret, Mac etc.) that store
/// and utilize byte(s)
class Bytes {
  final Uint8List _bytes;

  /// General constructor with defined bytes
  Bytes(this._bytes) {
    ArgumentError.checkNotNull(_bytes, 'bytes');
  }

  /// Generate a random byte list of [length] long
  Bytes.random([int length = 16]) : _bytes = randomBytes(length);

  /// Generate a random byte list prefixed with timestamp.
  ///
  /// *NOTE*: [length] must be at least 32 or it'll throw
  Bytes.timedRandom([int length = 32])
      : assert(length >= 32),
        _bytes = timedRandomBytes(length);

  /// Get bytes from string
  Bytes.fromString(String value)
      : assert(value?.isNotEmpty ?? false),
        _bytes = value.encodedBytes();

  /// get the actual bytes
  Uint8List get extract => _bytes;

  @override
  int get hashCode => _bytes.hash();

  @override
  bool operator ==(check) => check is Bytes && _bytes.equals(check._bytes);

  @override
  String toString() => _bytes.encodedString();
}
