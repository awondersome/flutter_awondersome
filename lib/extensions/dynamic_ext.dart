/// 扩展此函数为接收后端数据做类型判断
/// 将json的类型声明为Map<String, Object?>
/// 就可以使用json["xx"].asInt
/// 如果类型不匹配，都会被强制赋值
/// int = 0
/// double = 0
/// bool = false
/// String = ''

extension DynamicExt on dynamic {
  int asInt() {
    if (this is int) return this;
    return 0;
  }

  double asDouble() {
    if (this is double) return this;
    return 0;
  }

  bool asBool() {
    if (this is bool) return this;
    return false;
  }

  String asString() {
    if (this is String) return this;
    return '';
  }

  List asList() {
    if (this is List) return this;
    return [];
  }

  Map<String, Object?> asMap() {
    if (this is Map) return this;
    return {};
  }
}
