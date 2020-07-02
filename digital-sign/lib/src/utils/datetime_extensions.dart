extension DateTimeExtensions on DateTime {
  String get microString => '$year${_padded(month)}${_padded(day)}'
      '${_padded(hour)}${_padded(minute)}${_padded(second)}'
      '.${_padded(millisecond, 4)}${_padded(microsecond, 4)}';

  double get microDouble => double.tryParse(microString);
}

String _padded(int val, [int padding = 2]) =>
    val.toString().padLeft(padding, '0');
