import 'dart:async';
import 'dart:ui';

/* Example:
final _searchDebouncer = Debouncer(milliseconds: 300);

_searchDebouncer.run(
  () {
    ///Your search logic
  },
);
*/
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 300});

  run(VoidCallback action) {
    _timer?.cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
