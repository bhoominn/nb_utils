import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as service;
import 'package:nb_utils/nb_utils.dart';

RegExp alphaRegExp = RegExp(r'^[a-zA-Z]+$');

// String Extensions
extension StringExtension on String? {
  /// Check email validation
  bool validateEmail() => hasMatch(this, Patterns.email);

  /// Check email validation
  bool validateEmailEnhanced() => hasMatch(this, Patterns.emailEnhanced);

  /// Check phone validation
  bool validatePhone() => hasMatch(this, Patterns.phone);

  /// Check URL validation
  bool validateURL() => hasMatch(this, Patterns.url);

  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  // Check null string, return given value if null
  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  /// Capitalize given String
  String capitalizeFirstLetter() => (validate().isNotEmpty)
      ? (this!.substring(0, 1).toUpperCase() + this!.substring(1).toLowerCase())
      : validate();

  /// Image regex
  bool get isImage => hasMatch(this, Patterns.image);

  /// Audio regex
  bool get isAudio => hasMatch(this, Patterns.audio);

  /// Video regex
  bool get isVideo => hasMatch(this, Patterns.video);

  /// Txt regex
  bool get isTxt => hasMatch(this, Patterns.txt);

  /// Document regex
  bool get isDoc => hasMatch(this, Patterns.doc);

  /// Excel regex
  bool get isExcel => hasMatch(this, Patterns.excel);

  /// PPT regex
  bool get isPPT => hasMatch(this, Patterns.ppt);

  /// Document regex
  bool get isApk => hasMatch(this, Patterns.apk);

  /// PDF regex
  bool get isPdf => hasMatch(this, Patterns.pdf);

  /// HTML regex
  bool get isHtml => hasMatch(this, Patterns.html);

  /// Return true if given String is Digit
  bool isDigit() {
    if (validate().isEmpty) {
      return false;
    }
    if (validate().length > 1) {
      for (var r in this!.runes) {
        if (r ^ 0x30 > 9) {
          return false;
        }
      }
      return true;
    } else {
      return this!.runes.first ^ 0x30 <= 9;
    }
  }

  bool get isInt => this!.isDigit();

  /// Check weather String is alpha or not
  bool isAlpha() => alphaRegExp.hasMatch(validate());

  bool isJson() {
    try {
      json.decode(validate());
    } catch (e) {
      return false;
    }
    return true;
  }

  // Copy String to Clipboard
  Future<void> copyToClipboard() async {
    await service.Clipboard.setData(service.ClipboardData(text: validate()));
  }

  /// for ex. add comma in price
  String formatNumberWithComma({String seperator = ','}) {
    return validate().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}$seperator',
    );
  }

  /// Get Color from HEX String
  Color toColor({Color? defaultColor}) {
    return getColorFromHex(validate(), defaultColor: defaultColor);
  }

  /// It reverses the String
  String get reverse {
    if (validate().isEmpty) {
      return '';
    }
    return toList().reversed.reduce((value, element) => value += element);
  }

  /// It return list of single character from String
  List<String> toList() {
    return validate().trim().split('');
  }

  /// Splits from a [pattern] and returns remaining String after that
  String splitAfter(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    var matchIterator = pattern.allMatches(this!).iterator;

    if (matchIterator.moveNext()) {
      var match = matchIterator.current;
      var length = match.end - match.start;
      return validate().substring(match.start + length);
    }
    return '';
  }

  /// Splits from a [pattern] and returns String before that
  String splitBefore(Pattern pattern) {
    ArgumentError.checkNotNull(pattern, 'pattern');
    var matchIterator = pattern.allMatches(validate()).iterator;

    Match? match;
    while (matchIterator.moveNext()) {
      match = matchIterator.current;
    }

    if (match != null) {
      return validate().substring(0, match.start);
    }
    return '';
  }

  /// It matches the String and returns between [startPattern] and [endPattern]
  String splitBetween(Pattern startPattern, Pattern endPattern) {
    return splitAfter(startPattern).splitBefore(endPattern);
  }

  /// Return int value of given string
  int toInt({int defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (isDigit()) {
      return int.parse(this!);
    } else {
      return defaultValue;
    }
  }

  /// Return double value of given string
  double toDouble({double defaultValue = 0.0}) {
    if (this == null) return defaultValue;

    try {
      return double.parse(this!);
    } catch (e) {
      return defaultValue;
    }
  }

  /// Get YouTube Video ID
  String toYouTubeId({bool trimWhitespaces = true}) {
    String url = validate();
    if (!url.contains('http') && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https://(?:www\.|m\.)?youtube\.com/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https://(?:www\.|m\.)?youtube(?:-nocookie)?\.com/embed/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https://youtu\.be/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1)!;
    }

    return '';
  }

  /// Get YouTube Video ID
  @Deprecated('Use toYouTubeId Instead')
  String convertYouTubeUrlToId({bool trimWhitespaces = true}) {
    return toYouTubeId(trimWhitespaces: trimWhitespaces);
  }

  /// Returns YouTube thumbnail for given video id
  String getYouTubeThumbnail({bool trimWhitespaces = true}) {
    return 'https://img.youtube.com/vi/${toYouTubeId(trimWhitespaces: trimWhitespaces)}/maxresdefault.jpg';
  }

  /// Removes white space from given String
  String removeAllWhiteSpace() =>
      validate().replaceAll(RegExp(r"\s+\b|\b\s"), "");

  /// toast a String
  void toastString() {
    toast(this);
  }

  /// Returns only numbers from a string trim Whitespaces
  String getNumericOnly({bool aFirstWordOnly = false}) {
    String numericOnlyString = '';

    for (var i = 0; i < validate().length; i++) {
      if ((this![i].isDigit())) {
        numericOnlyString += this![i];
      }
      if (aFirstWordOnly && numericOnlyString.isNotEmpty && this![i] == " ") {
        break;
      }
    }

    return numericOnlyString;
  }

  /// Returns the given string n times
  String repeat(int n, {String separator = ''}) {
    if (n < 0) ArgumentError('n must be a positive value greater then 0');

    var repeatedString = '';

    for (var i = 0; i < n; i++) {
      if (i > 0) {
        repeatedString += separator;
      }
      repeatedString += validate();
    }

    return repeatedString;
  }

  /// Render a HTML String
  String get renderHtml {
    return this!
        .replaceAll('&ensp;', ' ')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&emsp;', ' ')
        .replaceAll('<br>', '\n')
        .replaceAll('<br/>', '\n')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }

  /// Return average read time duration of given String in seconds
  double calculateReadTime({int wordsPerMinute = 200}) {
    var words = countWords();
    var number = words / wordsPerMinute;
    return number;
  }

  /// Return number of words ina given String
  int countWords() {
    var words = validate().trim().split(RegExp(r'(\s+)'));
    return words.length;
  }

  /// Generate slug of a given String
  String toSlug({String delimiter = '_'}) {
    String text = validate().trim().toLowerCase();
    return text.replaceAll(' ', delimiter);
  }

  /// returns searchable array for Firebase Database
  List<String> setSearchParam() {
    String word = validate();

    List<String> caseSearchList = [];
    String temp = '';

    for (int i = 0; i < word.length; i++) {
      temp = temp + word[i];
      caseSearchList.add(temp.toLowerCase());
    }

    return caseSearchList;
  }

  /// Returns true if given value is '1', else returns false
  bool getBoolInt() {
    if (this == "1") {
      return true;
    }
    return false;
  }

  ///  eg. Text("Dr. ${VARIABLE_NAME}"); =>  Text("VARIABLE_NAME.prefixText("Dr.")");
  String prefixText({required String value}) {
    return '$value$this';
  }

  ///  eg. Text("${VARIABLE_NAME} /-"); =>  Text("VARIABLE_NAME.suffixText("/-")");
  String suffixText({required String value}) {
    return '$this$value';
  }

  /// This function returns given string with each word capital
  String capitalizeEachWord() {
    if (validate().isEmpty) {
      return '';
    }

    final capitalizedWords = this!.split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      final firstLetter = word[0].toUpperCase();
      final remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });

    return capitalizedWords.join(' ');
  }

  /// Returns true if the validate() method returns 'true', otherwise returns false.
  bool toBool() => validate() == 'true';

  /// helper function to mask email and phone strings.
  String mask({MaskType maskType = MaskType.auto, bool? isMaskingEnabled}) {
    String data = validate();
    isMaskingEnabled ??= isMaskingEnabledGlobal;

    if (!isMaskingEnabledGlobal && !isMaskingEnabled) {
      return data; // Return original data if masking is disabled
    }
    if (isMaskingEnabledGlobal && !isMaskingEnabled) {
      return data; // Return original data if masking is disabled
    }

    if (maskType == MaskType.auto) {
      if (data.validateEmail()) {
        return maskEmail();
      } else if (data.validatePhone()) {
        return maskPhone();
      }
    }
    if (maskType == MaskType.email) {
      return maskEmail();
    } else if (maskType == MaskType.phone) {
      return maskPhone();
    }

    return data; // Return original data if something goes wrong
  }

  /// Mask email (e.g., user@example.com -> u***@example.com)
  String maskEmail({bool? isMaskingEnabled}) {
    String data = validate();

    isMaskingEnabled ??= isMaskingEnabledGlobal;

    if (!isMaskingEnabledGlobal && !isMaskingEnabled) {
      return data; // Return original data if masking is disabled
    }
    if (isMaskingEnabledGlobal && !isMaskingEnabled) {
      return data; // Return original data if masking is disabled
    }

    final parts = data.split('@');
    if (parts.length == 2) {
      final namePart = parts[0].substring(0, 1);
      final domainPart = parts[1];
      final maskedName = namePart + '*' * (parts[0].length - 1);
      return '$maskedName@$domainPart';
    }
    return data;
  }

  /// Mask phone (e.g., 1234567890 -> 12****7890)
  String maskPhone({bool? isMaskingEnabled}) {
    String data = validate();

    isMaskingEnabled ??= isMaskingEnabledGlobal;

    if (!isMaskingEnabledGlobal && !isMaskingEnabled) {
      return data; // Return original data if masking is disabled
    }
    if (isMaskingEnabledGlobal && !isMaskingEnabled) {
      return data; // Return original data if masking is disabled
    }

    final length = data.length;
    if (length > 4) {
      final prefix = data.substring(0, 2);
      final suffix = data.substring(length - 2);
      final maskedMiddle = '*' * (length - 4);
      return '$prefix$maskedMiddle$suffix';
    }
    return data;
  }

  /// Returns true if the validate() method returns 'true', otherwise returns false.
  bool get asBool => this == 'true';
}
