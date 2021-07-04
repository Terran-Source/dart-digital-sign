part of marganam.cipher;

class Nonce extends Bytes {
  Nonce(Uint8List bytes) : super(bytes);

  Nonce.random([int length = 16]) : super.random(length);

  Nonce.timedRandom([int length = 32])
      : assert(length >= 32),
        super.timedRandom(length);

  Nonce.fromString(String value)
      : assert(isNonceString(value)),
        super.fromString(value.split(':')[1]);

  static bool isNonceString(String value) =>
      (value?.isNotEmpty ?? false) && value.startsWith('Nonce:');

  @override
  String toString() => 'Nonce:${super.toString()}';
}
