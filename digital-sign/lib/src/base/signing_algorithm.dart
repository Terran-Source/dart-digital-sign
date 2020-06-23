library marganam.signing_algorithm;

import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_sign/src/utils/equality.dart';
import 'package:digital_sign/src/utils/happy_hash.dart';
import 'package:digital_sign/src/utils/hash.dart';

part 'key.dart';
part 'key_pair.dart';
part 'signature.dart';

abstract class SigningAlgorithm<PrivateKey extends Key, PublicKey extends Key> {
  const SigningAlgorithm();
  SigningAlgorithm.from(String key);

  String get name;

  Future<KeyPair<PrivateKey, PublicKey>> generateKeyPair(
      {Uint8List passPhrase});
  Future<KeyPair<PrivateKey, PublicKey>> generateKeyPairWithSeed(
      PrivateKey seed,
      {Uint8List passPhrase});
  Future<KeyPair<PrivateKey, PublicKey>> armoredKeyPair(
      KeyPair<PrivateKey, PublicKey> keyPair, Uint8List passPhrase);
  Future<PrivateKey> armoredPrivateKey(PrivateKey key, Uint8List passPhrase);
  Future<PublicKey> armoredPublicKey(PrivateKey key, Uint8List passPhrase);
  Future<Signature> sign(
      Uint8List message, KeyPair<PrivateKey, PublicKey> keyPair);
  Future<bool> verify(List<Uint8List> message, Signature signature);
}
