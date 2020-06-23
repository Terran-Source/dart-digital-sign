extension StringScrambler on String {
  String scramble() {
    var value = '*** === ***';
    if (null != this) {
      value = '$value. ${this.reduce()} .$value';
    }
    return value;
  }

  String reduce({int maxLength = 5, String extender = '...'}) {
    if (maxLength <= 0) return '';
    if (length < ((maxLength * 2) + extender.length)) return this;
    return '${this.substring(0, maxLength)}$extender${this.substring(length - maxLength)}';
  }
}
