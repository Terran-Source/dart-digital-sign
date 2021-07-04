library marganam.byte_converter;

import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';

extension IterableIntConverter on Iterable<int> {
  @experimental
  String encodeString() => utf8.decode(this); // TODO
  String encodedString() => String.fromCharCodes(this);
  String encodeHexString() => this.map(_IntToHex).join(' ');
  String encodeByteHexString() => this
      .toByteList()
      .map((val) => _IntToHex(val, withPrefix: false))
      .join(' ');
  Uint8List toByteList() => Uint8List.fromList(this
      .fold(List<int>(), (intList, val) => intList..addAll(_IntToBytes(val))));
}

extension StringConverter on String {
  @experimental
  Uint8List encodeBytes() => Uint8List.fromList(utf8.encode(this)); // TODO
  Uint8List encodedBytes() => this.codeUnits.toByteList();
  Uint16List encodeUint16() => Uint16List.fromList(this.codeUnits);
  Uint8List encodeHexBytes() => this
      .split(r'\s')
      .map((val) => _HexToInt(val, withPrefix: false))
      .toByteList();
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

List<int> _IntToBytes(int val) {
  var _current = val;
  var result = List<int>();
  do {
    // cut out least 8 bytes
    // eg: 1472 (00000101-11000000) -> 192 (11000000)
    result.add(_current & 0xff);
    // shift least 8 bytes out
    // eg: 1472 (00000101-11000000) ->   5 (00000101)
    _current >>= 8;
  } while (_current > 0);
  return result;
}
