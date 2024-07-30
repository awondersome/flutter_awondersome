extension MapExt on Map {
  ValueOfMap of(String key) {
    return ValueOfMap(this[key]);
  }
}

class ValueOfMap {
  dynamic value;

  ValueOfMap(value);

  toInt() {
    if (value is int) return value;
    return 0;
  }
}
