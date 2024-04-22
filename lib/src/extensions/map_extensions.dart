extension MapExt on Map<String, dynamic> {
  String joinWithMap(String separator, {String keyValueSeparator = '='}) {
    return entries
        .map((entry) => "${entry.key}$keyValueSeparator${entry.value}")
        .join(separator);
  }
}
