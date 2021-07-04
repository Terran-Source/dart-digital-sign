import 'dart:convert';

import 'package:digital_sign/digital_sign.dart';

void main() {
  var privateKey = PrivateKey.random(Bytes.timedRandom(32).extract, 512);
  print('privateKey.toString: ${privateKey.toString()}');
  final ext = privateKey.extract;
  print('privateKey.extract: ${ext}');
  print('privateKey.extract.length: ${ext.length}');
  print('encoded(privateKey.extract): ${Key.encodeString(ext)}');
  print(
      'decoded(privateKey.extract): ${Key.decodeString(Key.encodeString(privateKey.extract))}');

  var word = 'Word';
  var word2 = 'Word2';
  var combined = '$word\n$word2';
  var map = <String, String>{"val": combined};
  print('combined: $combined');
  print('json.encode(map): ${json.encode(map)}');
  print('map["val"]: ${map['val']}');
  var bytes = randomBytes(32);
  var encodedBytesString = Key.encodeString(bytes);
  print('bytes: $bytes');
  print('encodedBytesString: $encodedBytesString');
  print('decodedBytesString: ${Key.decodeString(encodedBytesString)}');
  print(
      'encodedBytesString == decodedBytesString: ${bytes.equals(Key.decodeString(encodedBytesString))}');

  var stringLength = 250;
  var randStr = randomString(stringLength);
  print('random String($stringLength): $randStr');
  print('random String Length: ${randStr.length}');

  // for (var i = 0; i < 0x1000; i++) {
  //   print('${i.toString().padLeft(3, ' ')}: ${String.fromCharCode(i)} '
  //       '- ${[i].encodeHexString()}');
  // }
}
