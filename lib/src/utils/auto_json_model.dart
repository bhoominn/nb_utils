import 'dart:convert';

abstract class JsonModel {
  final Map<String, dynamic> _fieldMap = {};

  /// Automatically register all fields passed to constructor
  void registerFields({Map<String, dynamic>? fields}) {
    _fieldMap.addAll(fields ?? {});
  }

  /*void fromJson(Map<String, dynamic> json) {
    for (var key in json.keys) {
      _fieldMap[key] = json[key];
    }
  }*/

  T? getField<T>(String key, {T? defaultValue}) {
    final value = _fieldMap[key];
    if (value == null) return defaultValue;
    if (value is T) return value;
    print(
      "❌ Type mismatch for '$key': Expected $T but got ${value.runtimeType}\n"
      "💡 Value: $value",
    );
    return null;
  }

  T? getModel<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final value = _fieldMap[key];
    if (value is Map<String, dynamic>) {
      return fromJson(value);
    }
    return null;
  }

  List<T>? getModelList<T>(
      String key, T Function(Map<String, dynamic>) fromJson) {
    final value = _fieldMap[key];
    if (value is List) {
      return value
          .whereType<Map<String, dynamic>>()
          .map((item) => fromJson(item))
          .toList();
    }
    return null;
  }

  List<T>? getFieldList<T>(String key, {List<T>? defaultValue}) {
    final value = _fieldMap[key];
    if (value is List) {
      try {
        return value.map((e) => e as T).toList();
      } catch (e) {
        print(
          "❌ Type error in '$key': Expected List<$T>, got List<${value.map((e) => e.runtimeType).toSet()}>\n"
          "💡 Value: $value",
        );
      }
    }
    return defaultValue;
  }

  Map<String, dynamic> toJson() => Map.from(_fieldMap);

  String toJsonString() {
    return jsonEncode(_fieldMap);
  }

  String toJsonPretty() {
    return const JsonEncoder.withIndent('  ').convert(_fieldMap);
  }
}
