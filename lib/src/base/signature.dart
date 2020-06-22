part of marganam.signing_algorithm;

class Signature<PublicKey extends Key> {
  final String algorithm;
  final String key;
  final Uint8List _bytes;

  Signature._(this.algorithm, this.key, this._bytes)
      : assert(null != algorithm),
        assert(null != key),
        assert(null != _bytes);
  factory Signature.fromValues(String algorithm, String key, String signature) {
    assert(null != signature);
    return Signature._(algorithm, key, utf8.encode(signature));
  }
  factory Signature.fromString(String extract) {
    assert(null != extract);
    final Map<String, String> valueMap = json.decode(extract);
    return Signature.fromValues(
        valueMap['algorithm'], valueMap['key'], valueMap['signature']);
  }

  bool verified(Uint8List check) => _bytes.equals(check);

  @override
  String toString() {
    final valueMap = {
      'algorithm': algorithm,
      'signature': utf8.decode(_bytes),
      'key': key
    };
    return json.encode(valueMap);
  }
}
