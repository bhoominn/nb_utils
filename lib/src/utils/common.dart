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
  bool print = false,
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
    if (print) log(value);
  }
}

void toasty(
  BuildContext context,
  String? text, {
  ToastGravity? gravity,
  length = Toast.LENGTH_SHORT,
  Color? bgColor,
  Color? textColor,
  bool print = false,
  bool removeQueue = false,
  Duration? duration,
  BorderRadius? borderRadius,
  EdgeInsets? padding,
}) {
  FToast().init(context);
  if (removeQueue) FToast().removeCustomToast();

  FToast().showToast(
    child: Container(
      child: Text(text.validate(),
          style: boldTextStyle(color: textColor ?? defaultToastTextColor)),
      decoration: BoxDecoration(
        color: bgColor ?? defaultToastBackgroundColor,
        boxShadow: defaultBoxShadow(),
        borderRadius: borderRadius ?? defaultToastBorderRadiusGlobal,
      ),
      padding: padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 30),
    ),
    gravity: gravity ?? defaultToastGravityGlobal,
    toastDuration: duration,
  );
  if (print) log(text);
}

/// Toast for long period of time
void toastLong(
  String? value, {
  BuildContext? context,
  ToastGravity gravity = ToastGravity.BOTTOM,
  length = Toast.LENGTH_LONG,
  Color? bgColor,
  Color? textColor,
  bool print = false,
}) {
  toast(
    value,
    gravity: gravity,
    bgColor: bgColor,
    textColor: textColor,
    length: length,
    print: print,
  );
}

/// Show SnackBar
void snackBar(
  BuildContext context, {
  String title = '',
  Widget? content,
  SnackBarAction? snackBarAction,
  Function? onVisible,
  Color? textColor,
  Color? backgroundColor,
  EdgeInsets? margin,
  EdgeInsets? padding,
  Animation<double>? animation,
  double? width,
  ShapeBorder? shape,
  Duration? duration,
  SnackBarBehavior? behavior,
  double? elevation,
}) {
  if (title.isEmpty && content != null) {
    log('SnackBar message is empty');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        action: snackBarAction,
        margin: margin,
        animation: animation,
        width: width,
        shape: shape,
        duration: 4.seconds,
        behavior: margin != null ? SnackBarBehavior.floating : behavior,
        elevation: elevation,
        onVisible: onVisible?.call(),
        content: content ??
            Padding(
              padding: padding ?? EdgeInsets.symmetric(vertical: 4),
              child: Text(
                title,
                style: primaryTextStyle(color: textColor ?? Colors.white),
              ),
            ),
      ),
    );
  }
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
