library marganam.byte_converter;

import 'dart:convert';
import 'dart:typed_data';

extension IterableIntConverter on Iterable<int> {
  String encodeString() => utf8.decode(this);
  String encodeHexString() => this.map(_IntToHex).join(' ');
}

extension StringConverter on String {
  Uint8List encodeBytes() => utf8.encode(this);
  Uint8List encodeUint16() => this.codeUnits;
  Uint8List encodeHexBytes() => this.split(r'\s').map(_HexToInt);
}

String _IntToHex(int val, {bool withPrefix = true}) {
  if (null == val || val < 0) {
    throw ArgumentError.value(val, 'input', '$val out of range of conversion');
  }
  return '${withPrefix ? '0x' : ''}${val.toRadixString(16)}';
}

int _HexToInt(String val, {bool withPrefix = true}) {
  final result = int.tryParse('${withPrefix ? '' : '0x'}$val');
  if (null == result)
    throw ArgumentError.value(val, 'input', '$val out of range of conversion');
  return result;
}
