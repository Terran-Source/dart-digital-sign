part of marganam.signing_algorithm;

abstract class Key {
  final Uint8List _birthMark;
  final Uint8List _bytes;
  Key(this._birthMark, this._bytes, [this.isArmored = false]) {
    ArgumentError.checkNotNull(_birthMark, 'birthMark');
    ArgumentError.checkNotNull(_bytes, 'bytes');
    isArmored = isArmored ?? false;
  }

  factory Key.fromJson(String jsonString) = PublicKey.fromJson;

  bool isArmored;
  bool get _secureOnly;

  Uint8List _passPhrase;
  set passPhrase(Uint8List val) {
    ArgumentError.checkNotNull(val, 'passPhrase');
    _passPhrase = val;
  }

  String get boundary;
  Uint8List get extract => _deArmored();
  Uint8List get parent => _birthMark;
  Uint8List get _secureBytes => ((!_secureOnly) || (_secureOnly && isArmored))
      ? _bytes
      : _scramble(_bytes);

  static Uint8List _scramble(Uint8List bytes) =>
      decodeString(((null == bytes) ? '' : encodeString(bytes)).scramble());

  // TODO: implementation of armored
  static Uint8List armored(Uint8List bytes, Uint8List passPhrase) {
    if (null == passPhrase) {
      // throw
      return bytes;
    } else {
      return bytes;
    }
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

  static String encodeString(Uint8List value) =>
      value.encodedString(); //.encodeString();
  static Uint8List decodeString(String value) =>
      value.encodedBytes(); //.encodeBytes();
  static String encodeHex(Uint8List value) => value.encodeByteHexString();
  static Uint8List decodeHex(String value) => value.encodeHexBytes();

  static String _withBoundary(Uint8List value, String boundary) {
    if (null == value) return null;
    return '$boundary\n${encodeString(value)}\n$boundary';
  }

  static Uint8List _stripBoundary(String value) {
    if (null == value) return null;
    var cleansed = value.split(RegExp(r'\n', multiLine: true));
    return decodeString(cleansed[1]);
  }

  static Map<String, dynamic> _fromJson(String jsonString) {
    if (null == jsonString) return null;
    final Map<String, dynamic> map = json.decode(jsonString);
    return <String, dynamic>{
      'birthMark': decodeString(map['birthMark']),
      'key': _stripBoundary(map['key']),
      'isArmored': true.toString() == map['isArmored'],
    };
  }

  Map<String, String> _toJson() => <String, String>{
        'birthMark': encodeString(_birthMark),
        'key': _withBoundary(_secureBytes, boundary),
        'isArmored': isArmored.toString(),
      };

  @override
  String toString() => json.encode(_toJson());
}

class PublicKey extends Key {
  PublicKey(Uint8List birthMark, Uint8List bytes, [bool isArmored])
      : super(birthMark, bytes, isArmored);

  factory PublicKey.fromJson(String json) {
    final map = Key._fromJson(json);
    return PublicKey(map['birthMark'], map['key'], map['isArmored']);
  }

  /// A placeholder static function to enable PublicKey.armored().
  ///
  /// If [armored] is overridden, it affects [_deArmored], too.
  static Uint8List armored(Uint8List bytes, Uint8List passPhrase) =>
      Key.armored(bytes, passPhrase);

  /// Effective implementation in response to change in PublicKey.armored().
  @override
  Uint8List _deArmored() => super._deArmored();

  @override
  String get boundary => '---## Digital Signing Public Kay ##---';

  @override
  bool get _secureOnly => false;

  @override
  int get hashCode {
    final base = base64Encode(_bytes);
    final baseBirth = base64Encode(_birthMark);
    final md5Hash =
        hashedAll([base, baseBirth], hashLength: 16, library: HashLibrary.md5);
    final intList = Key.decodeString(md5Hash);
    return intList.hash();
  }

  bool equals(check) =>
      parent.equals(check.parent) && extract.equals(check.extract);

  @override
  bool operator ==(check) => check is PublicKey && equals(check);
}

class PrivateKey extends PublicKey {
  static final List<int> supportedLength =
      List<int>.generate(5, (index) => pow(2, 8 + index));
  static String get _unsupportedMessage => 'Key length not supported. '
      'Must be one of ${supportedLength.join(', ')}';

  PrivateKey(Uint8List birthMark, Uint8List bytes, [bool isArmored])
      : super(birthMark, bytes, isArmored);

  factory PrivateKey.fromJson(String json) {
    final map = Key._fromJson(json);
    return PrivateKey(map['birthMark'], map['key'], map['isArmored']);
  }

  factory PrivateKey.random(Uint8List birthMark, int bitsLength) {
    if (supportedLength.any((element) => element == bitsLength)) {
      return PrivateKey(birthMark, randomBytes(bitsLength ~/ 8));
    }
    throw ArgumentError.value(bitsLength, 'bitsLength', _unsupportedMessage);
  }

  // A placeholder static function to enable PrivateKey.armored().
  ///
  /// If [armored] is overridden, it affects [_deArmored], too.
  static Uint8List armored(Uint8List bytes, Uint8List passPhrase) =>
      Key.armored(bytes, passPhrase);

  /// Effective implementation in response to change in PrivateKey.armored().
  @override
  Uint8List _deArmored() => super._deArmored();

  @override
  String get boundary => '---## Digital Signing Private Kay ##---';

  @override
  bool get _secureOnly => true;

  @override
  bool operator ==(check) => check is PrivateKey && equals(check);
}
