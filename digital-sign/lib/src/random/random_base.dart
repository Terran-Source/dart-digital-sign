library marganam.random;

import 'dart:convert';
import 'package:digital_sign/src/random/random_bytes.dart';

String randomString([int length = 16]) =>
    base64Encode(randomBytes(length)).substring(0, length);
