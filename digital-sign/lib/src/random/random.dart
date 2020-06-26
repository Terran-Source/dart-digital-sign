import 'dart:convert';
import 'dart:math';

import 'dart:typed_data';

final Random _random = Random.secure();

String randomString([int length = 16]) =>
    base64Encode(randomBytes(length, 256)).substring(0, length);

Uint8List randomBytes([int length = 16, maxInt = 256]) => Uint8List.fromList(
    List<int>.generate(length, (index) => _random.nextInt(maxInt)));
