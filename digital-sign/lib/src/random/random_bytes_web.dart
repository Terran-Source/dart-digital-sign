import 'dart:html' as html;
import 'dart:math';
import 'dart:typed_data';

final Random _random = Random.secure();
final _supported = html.Crypto.supported;
final _webCryptoRandom = html.window.crypto.getRandomValues;

Uint8List randomBytes([int length = 16]) => _supported
    ? _webCryptoRandom(Uint8List(length))
    : Uint8List.fromList(
        List<int>.generate(length, (index) => _random.nextInt(256)));
