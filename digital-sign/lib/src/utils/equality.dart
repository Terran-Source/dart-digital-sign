library marganam.equality;

extension IntListEquality on List<int> {
  bool equals(List<int> check) {
    if (this == null || check == null || length != check.length) {
      return false;
    }
    for (var i = (length - 1); i >= 0; --i) {
      if (0 != (this[i] ^ check[i])) return false;
    }
    return true;
  }
}
