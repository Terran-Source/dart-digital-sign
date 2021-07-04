library marganam.random;

import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_sign/src/utils/byte_converter.dart';
import 'package:digital_sign/src/utils/datetime_extensions.dart';

import 'random_bytes.dart';
export 'random_bytes.dart';

String randomString([int length = 16]) =>
    base64Encode(randomBytes(length)).substring(0, length);

String timedRandomString([int length = 32]) {
  if (length < 32)
    throw ArgumentError.value(
      length,
      'length',
      'Should be at least 32',
    );
  final microString = DateTime.now().toUtc().microsecondString;
  return '$microString${randomString(length - microString.length)}';
}

Uint8List timedRandomBytes([int length = 32]) {
  if (length < 32)
    throw ArgumentError.value(
      length,
      'length',
      'Should be at least 32',
    );
  var microBytes = DateTime.now().toUtc().microsecondString.encodedBytes();
  return Uint8List.fromList(
      microBytes + randomBytes(length - microBytes.length));
}
