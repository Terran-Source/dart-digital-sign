part of marganam.signing_algorithm;

class Signature {
  final String algorithm;
  final String key;
  final Uint8List _bytes;

  Signature._(this.algorithm, this.key, this._bytes)
      : assert(null != algorithm),
        assert(null != key),
        assert(null != _bytes);
  factory Signature.fromValues(String algorithm, String key, String signature) {
    assert(null != signature);
    return Signature._(algorithm, key, Key.decode(signature));
  }
  factory Signature.fromJson(Map<String, String> map) {
    assert(null != map);
    return Signature.fromValues(map['algorithm'], map['key'], map['signature']);
  }
  factory Signature.fromString(String extract) {
    assert(null != extract);
    return Signature.fromJson(json.decode(extract));
  }

  bool verified(Uint8List check) => _bytes.equals(check);

  Map<String, String> _toJson() => <String, String>{
        'algorithm': algorithm,
        'key': key,
        'signature': Key.encode(_bytes),
      };

  @override
  String toString() => json.encode(_toJson());
}
