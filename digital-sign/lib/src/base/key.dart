part of marganam.signing_algorithm;

abstract class Key {
  final Uint8List _bytes;
  const Key(this._bytes);

  Uint8List armored(String secret);
  String get boundary;
  Uint8List get extract;

  static Uint8List fromString(String value) {
    if (null == value) return null;
    var cleansed = value.split(RegExp(r'\n', multiLine: true));
    return utf8.encode(cleansed[1]);
  }

  @override
  String toString() => '$boundary\n${utf8.decode(_bytes)}\n$boundary';
}
