import 'dart:convert';

import 'package:digital_sign/digital_sign.dart';

void main() {
  var privateKey = PrivateKey.random(
      Key.decodeString(DateTime.now().toUtc().toString()), 32);
  print('awesome: ${privateKey.toString()}');
}
