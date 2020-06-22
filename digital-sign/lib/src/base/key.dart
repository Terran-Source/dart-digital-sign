part of marganam.signing_algorithm;

abstract class Key {
  final Uint8List _birthMark;
  final Uint8List _bytes;
  const Key(this._birthMark, this._bytes)
      : assert(null != _birthMark),
        assert(null != _bytes);

  Uint8List armored();
  String get boundary;
  Uint8List get extract;
  Uint8List get parent => _birthMark;

  static Uint8List fromString(String value) {
    if (null == value) return null;
    var cleansed = value.split(RegExp(r'\n', multiLine: true));
    return utf8.encode(cleansed[1]);
  }

  @override
  String toString() => '$boundary\n${utf8.decode(armored())}\n$boundary';
}

class PublicKey extends Key {
  PublicKey(Uint8List birthMark, Uint8List bytes) : super(birthMark, bytes);

  Uint8List _passPhrase;

  set passPhrase(Uint8List val) {
    assert(null != val);
    _passPhrase = val;
  }

  @override
  Uint8List armored() => _bytes;

  Uint8List _deArmored() => (null == _passPhrase) ? _bytes : _bytes;

  @override
  Uint8List get extract => _deArmored();

  @override
  String get boundary => '---## Digital Signing Public Kay ##---';

  @override
  int get hashCode {
    final base = base64Encode(_bytes);
    final baseBirth = base64Encode(_birthMark);
    final md5Hash =
        hashedAll([base, baseBirth], hashLength: 16, library: HashLibrary.md5);
    final intList = utf8.encode(md5Hash);
    return intList.hash();
  }

  @override
  bool operator ==(check) => check is PublicKey && _bytes.equals(check.extract);
}

class PrivateKey extends PublicKey {
  PrivateKey(Uint8List birthMark, Uint8List bytes) : super(birthMark, bytes);

  factory PrivateKey.random(Uint8List birthMark, int length) =>
      PrivateKey(birthMark, randomBytes(length));

  @override
  String get boundary => '---## Digital Signing Private Kay ##---';

  @override
  bool operator ==(check) =>
      check is PrivateKey &&
      _birthMark.equals(check.parent) &&
      _bytes.equals(check.extract);
}
