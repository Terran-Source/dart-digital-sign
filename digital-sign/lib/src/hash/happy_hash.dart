library marganam.happy_hash;

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

import 'package:digital_sign/src/random/random.dart';

enum HashLibrary {
  md5,
  sha1,
  sha224,
  sha256,
  sha384,
  sha512,
  hmac_md5,
  hmac_sha1,
  hmac_sha224,
  hmac_sha256,
  hmac_sha384,
  hmac_sha512
}

String hashedAll(
  List<String> items, {
  int hashLength = 16,
  HashLibrary library = HashLibrary.sha1,
  String key,
  bool prefixLibrary = false,
}) {
  final keyLength =
      null == hashLength ? 256 : hashLength < 4096 ? hashLength : 4096;
  final _key = key ?? randomString(keyLength);
  final utf8Key = utf8.encode(_key);
  final sink = AccumulatorSink<Digest>();
  final byteChunks = items.map((str) => utf8.encode(str));
  ByteConversionSink chunks;
  switch (library) {
    case HashLibrary.md5:
      chunks = md5.startChunkedConversion(sink);
      break;
    case HashLibrary.sha224:
      chunks = sha224.startChunkedConversion(sink);
      break;
    case HashLibrary.sha256:
      chunks = sha256.startChunkedConversion(sink);
      break;
    case HashLibrary.sha384:
      chunks = sha384.startChunkedConversion(sink);
      break;
    case HashLibrary.sha512:
      chunks = sha512.startChunkedConversion(sink);
      break;
    case HashLibrary.hmac_md5:
      final hmac = Hmac(md5, utf8Key);
      chunks = hmac.startChunkedConversion(sink);
      break;
    case HashLibrary.hmac_sha1:
      final hmac = Hmac(sha1, utf8Key);
      chunks = hmac.startChunkedConversion(sink);
      break;
    case HashLibrary.hmac_sha224:
      final hmac = Hmac(sha224, utf8Key);
      chunks = hmac.startChunkedConversion(sink);
      break;
    case HashLibrary.hmac_sha256:
      final hmac = Hmac(sha256, utf8Key);
      chunks = hmac.startChunkedConversion(sink);
      break;
    case HashLibrary.hmac_sha384:
      final hmac = Hmac(sha384, utf8Key);
      chunks = hmac.startChunkedConversion(sink);
      break;
    case HashLibrary.hmac_sha512:
      final hmac = Hmac(sha512, utf8Key);
      chunks = hmac.startChunkedConversion(sink);
      break;
    case HashLibrary.sha1:
    default:
      chunks = sha1.startChunkedConversion(sink);
      break;
  }
  byteChunks.forEach((bt) => chunks.add(bt));
  chunks.close();
  var result =
      '${prefixLibrary ? library.toString().split(".").last.replaceAll("_", "") + ':' : ''}'
      '${sink.events.single}';
  if (null == hashLength) return result;
  if (result.length < hashLength) {
    result += _key;
    if (result.length < hashLength) {
      result += randomString(hashLength - result.length);
    }
  }
  return result.substring(0, hashLength);
}

String hashed(
  String item, {
  int hashLength = 16,
  HashLibrary library = HashLibrary.sha1,
  String key,
  bool prefixLibrary = false,
}) =>
    hashedAll(
      [item],
      hashLength: hashLength,
      library: library,
      key: key,
      prefixLibrary: prefixLibrary,
    );
