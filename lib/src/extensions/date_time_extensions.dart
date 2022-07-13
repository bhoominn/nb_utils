import 'package:nb_utils/nb_utils.dart';

extension DateTimeExt on DateTime {
  /// Returns Time Ago
  String get timeAgo => formatTime(this.millisecondsSinceEpoch);

  /// Returns true if given date is today
  bool get isToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return DateTime(this.year, this.month, this.day) == today;
  }

  /// Returns true if given date is yesterday
  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    return DateTime(this.year, this.month, this.day) == yesterday;
  }

  /// Returns true if given date is tomorrow
  bool get isTomorrow {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    return DateTime(this.year, this.month, this.day) == tomorrow;
  }
}

/// return current time in milliseconds
int currentMillisecondsTimeStamp() => DateTime.now().millisecondsSinceEpoch;

/// return current timestamp
int currentTimeStamp() {
  return (DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();
}

/// return true if given year is an leap year
bool leapYear(int year) {
  bool leapYear = false;

  bool leap = ((year % 100 == 0) && (year % 400 != 0));
  if (leap == true)
    leapYear = false;
  else if (year % 4 == 0) leapYear = true;

  return leapYear;
}

/// returns number of days in given month
int daysInMonth(int monthNum, int year) {
  List<int> monthLength = [];

  monthLength[0] = 31;
  monthLength[2] = 31;
  monthLength[4] = 31;
  monthLength[6] = 31;
  monthLength[7] = 31;
  monthLength[9] = 31;
  monthLength[11] = 31;
  monthLength[3] = 30;
  monthLength[8] = 30;
  monthLength[5] = 30;
  monthLength[10] = 30;

  if (leapYear(year)) {
    monthLength[1] = 29;
  } else {
    monthLength[1] = 28;
  }

  return monthLength[monthNum - 1];
}
