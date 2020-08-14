part of marganam.signing_algorithm;

class Signature {
  final String algorithm;
  final String key;
  final Uint8List _bytes;

  Signature._(this.algorithm, this.key, this._bytes) {
    ArgumentError.checkNotNull(algorithm, 'algorithm');
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(_bytes, 'signature');
  }
  factory Signature.fromBytes(
      String algorithm, String key, Uint8List signature) {
    return Signature._(algorithm, key, signature);
  }
  factory Signature.fromValues(String algorithm, String key, String signature) {
    return Signature._(algorithm, key, Key.decodeString(signature));
  }
  factory Signature.fromJson(Map<String, String> json) {
    ArgumentError.checkNotNull(json, 'json');
    return Signature.fromValues(
        json['algorithm'], json['key'], json['signature']);
  }
  factory Signature.fromString(String extract) {
    ArgumentError.checkNotNull(extract, 'json');
    return Signature.fromJson(json.decode(extract));
  }

  bool verified(Uint8List check) => _bytes.equals(check);

  Map<String, String> _toJson() => <String, String>{
        'algorithm': algorithm,
        'key': key,
        'signature': Key.encodeString(_bytes),
      };

  @override
  String toString() => json.encode(_toJson());
}
