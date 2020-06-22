part of marganam.signing_algorithm;

class KeyPair<PrivateKey extends Key, PublicKey extends Key> {
  final PrivateKey privateKey;
  final PublicKey publicKey;

  KeyPair(this.privateKey, this.publicKey);
}
