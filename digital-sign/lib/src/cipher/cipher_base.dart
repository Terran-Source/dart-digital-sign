library marganam.cipher;

import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'package:digital_sign/src/hash/hash.dart';
import 'package:digital_sign/src/random/random.dart';
import 'package:digital_sign/src/utils/byte_converter.dart';
import 'package:digital_sign/src/utils/equality.dart';

part 'bytes.dart';
part 'nonce.dart';

abstract class Cipher {
  const Cipher();

  String get name;

  Future<Uint8List> encrypt<T>(
    Uint8List data, {
    @required Bytes secret,
    Nonce nonce,
    T support,
  }) async =>
      encryptSync(
        data,
        secret: secret,
        nonce: nonce,
        support: support,
      );

  Uint8List encryptSync<T>(
    Uint8List data, {
    @required Bytes secret,
    Nonce nonce,
    T support,
  });

  Future<int> encryptToBuffer<T>(
    Uint8List data, {
    @required Uint8List buffer,
    int bufferIndex = 0,
    @required Bytes secret,
    Nonce nonce,
    T support,
  }) async {
    ArgumentError.checkNotNull(buffer, 'buffer');
    final encrypted = await encrypt(
      data,
      secret: secret,
      nonce: nonce,
      support: support,
    );
    buffer.setAll(bufferIndex ?? 0, encrypted);
    return encrypted.length;
  }

  int encryptToBufferSync<T>(
    Uint8List data, {
    @required Uint8List buffer,
    int bufferIndex = 0,
    @required Bytes secret,
    Nonce nonce,
    T support,
  }) {
    ArgumentError.checkNotNull(buffer, 'buffer');
    final encrypted = encryptSync(
      data,
      secret: secret,
      nonce: nonce,
      support: support,
    );
    buffer.setAll(bufferIndex ?? 0, encrypted);
    return encrypted.length;
  }

  Future<Uint8List> decrypt<T>(
    Uint8List data, {
    @required Bytes secret,
    Nonce nonce,
    T support,
  }) async =>
      decryptSync(
        data,
        secret: secret,
        nonce: nonce,
        support: support,
      );

  Uint8List decryptSync<T>(
    Uint8List data, {
    @required Bytes secret,
    Nonce nonce,
    T support,
  });

  Future<int> decryptToBuffer<T>(
    Uint8List data, {
    @required Uint8List buffer,
    int bufferIndex = 0,
    @required Bytes secret,
    Nonce nonce,
    T support,
  }) async {
    ArgumentError.checkNotNull(buffer, 'buffer');
    final encrypted = await decrypt(
      data,
      secret: secret,
      nonce: nonce,
      support: support,
    );
    buffer.setAll(bufferIndex ?? 0, encrypted);
    return encrypted.length;
  }

  int decryptToBufferSync<T>(
    Uint8List data, {
    @required Uint8List buffer,
    int bufferIndex = 0,
    @required Bytes secret,
    Nonce nonce,
    T support,
  }) {
    ArgumentError.checkNotNull(buffer, 'buffer');
    final encrypted = decryptSync(
      data,
      secret: secret,
      nonce: nonce,
      support: support,
    );
    buffer.setAll(bufferIndex ?? 0, encrypted);
    return encrypted.length;
  }
}
