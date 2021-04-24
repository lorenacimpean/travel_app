extension ListExtensions<T> on List<T> {
  int get hash {
    if (this == null) return hashCode;
    return map((e) => e.hashCode)?.reduce((res, e) => res ^ e.hashCode) ??
        hashCode;
  }

  bool equals(List<T> other) {
    if (other == null && this == null) return true;
    if (other?.length != length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
