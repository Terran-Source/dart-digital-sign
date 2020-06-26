library marganam.signing_algorithm;

import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_sign/src/utils/converter.dart';
import 'package:digital_sign/src/utils/equality.dart';
import 'package:digital_sign/src/utils/happy_hash.dart';
import 'package:digital_sign/src/utils/hash.dart';
import 'package:digital_sign/src/utils/scrambler.dart';

part 'key.dart';
part 'key_pair.dart';
part 'signature.dart';

abstract class SigningAlgorithm<PrivateKey extends Key, PublicKey extends Key> {
  const SigningAlgorithm();

  /// name of the [SigningAlgorithm]
  String get name;

  /// Generate a new [KeyPair].
  ///
  /// If [passPhrase] is provided, it'll output a [KeyPair] with
  /// armored [PrivateKey]
  Future<KeyPair<PrivateKey, PublicKey>> generateKeyPair(
      {Uint8List passPhrase});

  /// Generate a new [KeyPair] using an existing [PrivateKey] as [seed].
  ///
  /// If [passPhrase] is provided, it'll output a [KeyPair] with
  /// armored [PrivateKey]
  Future<KeyPair<PrivateKey, PublicKey>> generateKeyPairWithSeed(
      PrivateKey seed,
      {Uint8List passPhrase});

  /// secure the [PrivateKey] using [passPhrase] & return a new [KeyPair],
  /// consisting the secured [PrivateKey] & the existing [PublicKey]
  Future<KeyPair<PrivateKey, PublicKey>> armoredKeyPair(
      KeyPair<PrivateKey, PublicKey> keyPair, Uint8List passPhrase);

  /// secure the [key] using [passPhrase]
  Future<PrivateKey> armoredPrivateKey(PrivateKey key, Uint8List passPhrase);

  /// secure the [key] using [passPhrase]
  Future<PublicKey> armoredPublicKey(PublicKey key, Uint8List passPhrase);

  /// signing the [message] using the [PrivateKey] and returns a [Signature],
  /// consisting `{ algorithm: [name], key: [PublicKey], signature: [Signed_Hash] }`
  Future<Signature> sign(
      Uint8List message, KeyPair<PrivateKey, PublicKey> keyPair);

  /// verify the authenticity of a [message], against the [Signature.Key]
  Future<bool> verify(List<Uint8List> message, Signature signature);
}
