import 'dart:typed_data';

import 'package:digital_sign/src/hash/hash.dart';
import 'package:digital_sign/src/random/random.dart';
import 'package:digital_sign/src/utils/byte_converter.dart';
import 'package:digital_sign/src/utils/datetime_extensions.dart';
import 'package:digital_sign/src/utils/equality.dart';

class Nonce {
  final Uint8List bytes;

  Nonce(this.bytes) {
    ArgumentError.checkNotNull(bytes, 'bytes');
  }

  factory Nonce.random([int length = 16]) => Nonce(randomBytes(length));

  factory Nonce.timedRandom([int length = 16]) {
    final timedString =
        '${DateTime.now().toUtc().microString}${randomString(length)}';

    return Nonce(timedString.encodeBytes());
  }

  Uint8List extract() => bytes;

  @override
  int get hashCode => bytes.hash();

  @override
  bool operator ==(check) => check is Nonce && bytes.equals(check.bytes);

  @override
  String toString() => bytes.encodeString();
}
