extension DateTimeExtensions on DateTime {
  String get microsecondString => '$millisecondString'
      '${_padded(microsecond, 4)}';

  String get millisecondString => '$secondString'
      '.${_padded(millisecond, 4)}';

  String get secondString => '$year${_padded(month)}${_padded(day)}'
      '${_padded(hour)}${_padded(minute)}${_padded(second)}';

  double get microsecondDouble => double.tryParse(microsecondString);
}

String _padded(int val, [int padding = 2]) =>
    val.toString().padLeft(padding, '0');
