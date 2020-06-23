part of marganam.signing_algorithm;

abstract class Key {
  final Uint8List _birthMark;
  final Uint8List _bytes;
  Key(this._birthMark, this._bytes, [this.isArmored = false])
      : assert(null != _birthMark),
        assert(null != _bytes) {
    isArmored = isArmored ?? false;
  }

  factory Key.fromJson(String jsonString) = PublicKey.fromJson;

  bool isArmored;

  Uint8List _passPhrase;
  set passPhrase(Uint8List val) {
    assert(null != val);
    _passPhrase = val;
  }

  String get boundary;
  Uint8List get extract => _deArmored();
  Uint8List get parent => _birthMark;

  // TODO: implementation of armored
  static Uint8List armored(Uint8List _bytes, Uint8List _passPhrase) {
    if (null == _passPhrase) // throw
      return _bytes;
    else
      return _bytes;
  }

  Uint8List _deArmored() {
    if (isArmored) {
      // TODO: implementation of de-armored
      return (null == _passPhrase)
          ? _bytes // throw
          : _bytes;
    }
    return _bytes;
  }

  static String encode(Uint8List value) => utf8.decode(value);
  static Uint8List decode(String value) => utf8.encode(value);

  static String _withBoundary(Uint8List value, String boundary) {
    if (null == value) return null;
    return '$boundary\n${encode(value)}\n$boundary';
  }

  static Uint8List _stripBoundary(String value) {
    if (null == value) return null;
    var cleansed = value.split(RegExp(r'\n', multiLine: true));
    return utf8.encode(cleansed[1]);
  }

  static Map<String, dynamic> _fromJson(String jsonString) {
    if (null == jsonString) return null;
    final Map<String, dynamic> map = json.decode(jsonString);
    return <String, dynamic>{
      'birthMark': decode(map['birthMark']),
      'key': _stripBoundary(map['key']),
      'isArmored': true.toString() == map['isArmored'],
    };
  }

  Map<String, String> _toJson() => <String, String>{
        'birthMark': encode(_birthMark),
        'key': _withBoundary(_bytes, boundary),
        'isArmored': isArmored.toString(),
      };

  @override
  String toString() => json.encode(_toJson());
}

class PublicKey extends Key {
  PublicKey(Uint8List birthMark, Uint8List bytes, [bool isArmored])
      : super(birthMark, bytes, isArmored);

  factory PublicKey.fromJson(String jsonString) {
    final map = Key._fromJson(jsonString);
    return PublicKey(map['birthMark'], map['key'], map['isArmored']);
  }

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

  bool equals(check) =>
      parent.equals(check.parent) && extract.equals(check.extract);

  @override
  bool operator ==(check) => check is PublicKey && equals(check);
}

class PrivateKey extends PublicKey {
  PrivateKey(Uint8List birthMark, Uint8List bytes, [bool isArmored])
      : super(birthMark, bytes, isArmored);

  factory PrivateKey.fromJson(String jsonString) {
    final map = Key._fromJson(jsonString);
    return PrivateKey(map['birthMark'], map['key'], map['isArmored']);
  }

  factory PrivateKey.random(Uint8List birthMark, int length) =>
      PrivateKey(birthMark, randomBytes(length));

  @override
  String get boundary => '---## Digital Signing Private Kay ##---';

  @override
  bool operator ==(check) => check is PrivateKey && equals(check);
}
