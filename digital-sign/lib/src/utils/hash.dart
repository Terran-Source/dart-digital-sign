extension IntListHashing on List<int> {
  // inspired by https://github.com/dint-dev/cryptography/blob/04b0746cc39dd92dfa5ba71d117120e5f853297b/cryptography/lib/src/private_key.dart#L96
  int hash() {
    var h = 0;
    final bytes = this;
    for (var i = bytes.length - 1; i >= 0; --i) {
      final b = bytes[i];

      // Exposes at most 31 bits
      h = 0x7FFFFFFF & ((31 * h) ^ b);
    }

    // For short values, expose max 15 bits.
    if (bytes.length < 8) {
      h = 0x7FFF & h;
    }

    return h;
  }
}
