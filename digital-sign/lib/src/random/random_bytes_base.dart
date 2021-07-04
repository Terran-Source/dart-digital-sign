import 'dart:math';
import 'dart:typed_data';

final Random _random = Random.secure();

Uint8List randomBytes([int length = 16]) => Uint8List.fromList(
    List<int>.generate(length, (index) => _random.nextInt(256)));
