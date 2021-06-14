import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/utils/system_utils.dart';

enum PageRouteAnimation { Fade, Scale, Rotate, Slide }

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

/// Toast for default time
void toast(
  String? value, {
  ToastGravity gravity = ToastGravity.BOTTOM,
  length = Toast.LENGTH_SHORT,
  Color? bgColor,
  Color? textColor,
}) {
  if (value.validate().isEmpty || isLinux) {
    log(value);
  } else {
    Fluttertoast.showToast(
      msg: value.validate(),
      gravity: gravity,
      toastLength: length,
      backgroundColor: bgColor,
      textColor: textColor,
    );
  }
}

/// Toast for long period of time
void toastLong(
  String value, {
  ToastGravity gravity = ToastGravity.BOTTOM,
  length = Toast.LENGTH_LONG,
  Color? bgColor,
  Color? textColor,
}) {
  toast(
    value,
    gravity: gravity,
    bgColor: bgColor,
    textColor: textColor,
    length: length,
  );
}

/// Hide soft keyboard
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

/// Returns a string from Clipboard
Future<String> paste() async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  return data?.text?.toString() ?? "";
}

/// Returns a string from Clipboard
Future<dynamic> pasteObject() async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  return data;
}
