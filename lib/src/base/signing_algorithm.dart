library marganam.signing_algorithm;

import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_sign/src/utils/equality.dart';

part 'key.dart';
part 'key_pair.dart';
part 'signature.dart';

abstract class SigningAlgorithm<PrivateKey extends Key, PublicKey extends Key> {
  const SigningAlgorithm();
  SigningAlgorithm.from(String key);

  String get name;

  Future<KeyPair<PrivateKey, PublicKey>> generateKeyPair();
  Future<KeyPair<PrivateKey, PublicKey>> generateKeyPairWithSeed(
      PrivateKey seed);
  Future<Signature<PublicKey>> sign(
      Uint8List message, KeyPair<PrivateKey, PublicKey> keyPair);
  Future<bool> verify(List<Uint8List> message, Signature<PublicKey> signature);
}