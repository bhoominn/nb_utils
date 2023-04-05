// Boolean Extensions
extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;

  /// get int value from bool
  int getIntBool({bool value = false}) {
    if (this ?? value) {
      return 1;
    } else {
      return 0;
    }
  }
}
