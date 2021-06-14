import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/utils/text_styles.dart';

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
  Animation<double>? animation,
  double? width,
  ShapeBorder? shape,
  Duration? duration,
  SnackBarBehavior? behavior,
  double? elevation,
}) {
  if (title.isEmpty) {
    log(title);
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
        behavior: behavior,
        elevation: elevation,
        onVisible: onVisible?.call(),
        content: content ??
            Text(
              title,
              style: primaryTextStyle(color: textColor ?? Colors.white),
            ),
      ),
    );
  }
}
