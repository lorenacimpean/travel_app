extension ListExtensions<T> on List<T> {
  // int get hash {
  //   if (this == null) return hashCode;
  //   return map((e) => e.hashCode)?.reduce((res, e) => res ^ e.hashCode) ??
  //       hashCode;
  // }

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

extension DynamicListExtension on List<dynamic> {
  List<T> toObjectList<T>(T Function(dynamic e) f) {
    if (this is! List || this == null) return null;
    return map(f).toList();
  }
}
