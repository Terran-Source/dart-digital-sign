import 'package:digital_sign/digital_sign.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    PrivateKey privateKey;

    setUp(() {
      privateKey =
          PrivateKey.random(Key.decodeString(DateTime.now().toString()), 32);
      ;
    });

    test('First Test', () {
      expect(privateKey.isArmored, isFalse);
    });
  });
}
