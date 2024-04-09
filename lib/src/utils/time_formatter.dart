/// returns how much time ago from timestamp
String formatTime(int timestamp) {
  /// The number of milliseconds that have passed since the timestamp
  int difference = DateTime.now().millisecondsSinceEpoch - timestamp;
  String result;

  if (difference < 60000) {
    result = countSeconds(difference);
  } else if (difference < 3600000) {
    result = countMinutes(difference);
  } else if (difference < 86400000) {
    result = countHours(difference);
  } else if (difference < 604800000) {
    result = countDays(difference);
  } else if (difference / 1000 < 2419200) {
    result = countWeeks(difference);
  } else if (difference / 1000 < 31536000) {
    result = countMonths(difference);
  } else {
    result = countYears(difference);
  }

  return !result.startsWith("J") ? '$result ago' : result;
}

/// Converts the time difference to a number of seconds.
/// This function truncates to the lowest second.
///   returns ("Just now" OR "X seconds")
String countSeconds(int difference) {
  int count = (difference / 1000).truncate();
  return count > 1 ? '$count seconds' : 'Just now';
}

/// Converts the time difference to a number of minutes.
/// This function truncates to the lowest minute.
///   returns ("1 minute" OR "X minutes")
String countMinutes(int difference) {
  int count = (difference / 60000).truncate();
  return count.toString() + (count > 1 ? ' minutes' : ' minute');
}

/// Converts the time difference to a number of hours.
/// This function truncates to the lowest hour.
///   returns ("1 hour" OR "X hours")
String countHours(int difference) {
  int count = (difference / 3600000).truncate();
  return count.toString() + (count > 1 ? ' hours' : ' hour');
}

/// Converts the time difference to a number of days.
/// This function truncates to the lowest day.
///   returns ("1 day" OR "X days")
String countDays(int difference) {
  int count = (difference / 86400000).truncate();
  return count.toString() + (count > 1 ? ' days' : ' day');
}

/// Converts the time difference to a number of weeks.
/// This function truncates to the lowest week.
///   returns ("1 week" OR "X weeks" OR "1 month")
String countWeeks(int difference) {
  int count = (difference / 604800000).truncate();
  if (count > 3) {
    return '1 month';
  }
  return count.toString() + (count > 1 ? ' weeks' : ' week');
}

/// Converts the time difference to a number of months.
/// This function rounds to the nearest month.
///   returns ("1 month" OR "X months" OR "1 year")
String countMonths(int difference) {
  int count = (difference / 2628003000).round();
  count = count > 0 ? count : 1;
  if (count > 12) {
    return '1 year';
  }
  return count.toString() + (count > 1 ? ' months' : ' month');
}

/// Converts the time difference to a number of years.
/// This function truncates to the lowest year.
///   returns ("1 year" OR "X years")
String countYears(int difference) {
  int count = (difference / 31536000000).truncate();
  return count.toString() + (count > 1 ? ' years' : ' year');
}
