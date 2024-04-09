import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

/// Make any variable nullable
T? makeNullable<T>(T? value) => value;

/// Enum for page route
enum PageRouteAnimation { Fade, Scale, Rotate, Slide, SlideBottomTop }

/// has match return bool for pattern matching
bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

/// Toast for default time
void toast(
  String? value, {
  ToastGravity? gravity,
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

/// Toast with Context
void toasty(
  BuildContext context,
  String? text, {
  ToastGravity? gravity,
  length = Toast.LENGTH_SHORT,
  Color? bgColor,
  Color? textColor,
  bool print = false,
  bool removeQueue = false,
  Duration duration = const Duration(seconds: 2),
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
  if (title.isEmpty && content == null) {
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
        duration: duration ?? 4.seconds,
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

/// Enum for Link Provider
enum LinkProvider {
  PLAY_STORE,
  APPSTORE,
  FACEBOOK,
  INSTAGRAM,
  LINKEDIN,
  TWITTER,
  YOUTUBE,
  REDDIT,
  TELEGRAM,
  WHATSAPP,
  FB_MESSENGER,
  GOOGLE_DRIVE
}

/// Use getSocialMediaLink function to build social media links
String getSocialMediaLink(LinkProvider linkProvider, {String url = ''}) {
  switch (linkProvider) {
    case LinkProvider.PLAY_STORE:
      return "$playStoreBaseURL$url";
    case LinkProvider.APPSTORE:
      return "$appStoreBaseURL$url";
    case LinkProvider.FACEBOOK:
      return "$facebookBaseURL$url";
    case LinkProvider.INSTAGRAM:
      return "$instagramBaseURL$url";
    case LinkProvider.LINKEDIN:
      return "$linkedinBaseURL$url";
    case LinkProvider.TWITTER:
      return "$twitterBaseURL$url";
    case LinkProvider.YOUTUBE:
      return "$youtubeBaseURL$url";
    case LinkProvider.REDDIT:
      return "$redditBaseURL$url";
    case LinkProvider.TELEGRAM:
      return "$telegramBaseURL$url";
    case LinkProvider.FB_MESSENGER:
      return "$facebookMessengerURL$url";
    case LinkProvider.WHATSAPP:
      return "$whatsappURL$url";
    case LinkProvider.GOOGLE_DRIVE:
      return "$googleDriveURL$url";
  }
}

/// Converts degrees to radians.
const double degrees2Radians = pi / 180.0;

/// Converts degrees to radians.
double radians(double degrees) => degrees * degrees2Radians;

/// Executes a function after the build is created.
void afterBuildCreated(Function()? onCreated) {
  makeNullable(SchedulerBinding.instance)!
      .addPostFrameCallback((_) => onCreated?.call());
}

/// Widget wrapper for animated dialog transitions.
Widget dialogAnimatedWrapperWidget({
  required Animation<double> animation,
  required Widget child,
  required DialogAnimation dialogAnimation,
  required Curve curve,
}) {
  switch (dialogAnimation) {
    // Animation for rotating the dialog.
    case DialogAnimation.ROTATE:
      return Transform.rotate(
        angle: radians(animation.value * 360),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // Animation for sliding the dialog from top to bottom.
    case DialogAnimation.SLIDE_TOP_BOTTOM:
      final curvedValue = curve.transform(animation.value) - 1.0;

      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 300, 0.0),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // Animation for scaling the dialog.
    case DialogAnimation.SCALE:
      return Transform.scale(
        scale: animation.value,
        child: FadeTransition(opacity: animation, child: child),
      );

    // Animation for sliding the dialog from bottom to top.
    case DialogAnimation.SLIDE_BOTTOM_TOP:
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // Animation for sliding the dialog from left to right.
    case DialogAnimation.SLIDE_LEFT_RIGHT:
      return SlideTransition(
        position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // Animation for sliding the dialog from right to left.
    case DialogAnimation.SLIDE_RIGHT_LEFT:
      return SlideTransition(
        position: Tween(begin: Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    // Default fade animation.
    case DialogAnimation.DEFAULT:
      return FadeTransition(opacity: animation, child: child);
  }
}

/// Builds a page route with the specified animation.
Route<T> buildPageRoute<T>(
  Widget child,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
) {
  if (pageRouteAnimation != null) {
    if (pageRouteAnimation == PageRouteAnimation.Fade) {
      // Fade animation for page route.
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Rotate) {
      // Rotation animation for page route.
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return RotationTransition(
              child: child, turns: ReverseAnimation(anim));
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Scale) {
      // Scale animation for page route.
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return ScaleTransition(child: child, scale: anim);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Slide) {
      // Slide animation for page route.
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            child: child,
            position: Tween(
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(anim),
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.SlideBottomTop) {
      // Slide from bottom to top animation for page route.
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            child: child,
            position: Tween(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(anim),
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    }
  }
  // Default page route.
  return MaterialPageRoute<T>(builder: (_) => child);
}

/// Provides dynamic padding for app buttons based on the context.
EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  if (context.isDesktop()) {
    return EdgeInsets.symmetric(vertical: 20, horizontal: 20);
  } else if (context.isTablet()) {
    return EdgeInsets.symmetric(vertical: 16, horizontal: 16);
  } else {
    return EdgeInsets.symmetric(vertical: 14, horizontal: 16);
  }
}

/// Enum representing types of bottom sheet dialogs.
enum BottomSheetDialog { Dialog, BottomSheet }

/// Shows a bottom sheet or a dialog based on the specified type.
Future<dynamic> showBottomSheetOrDialog({
  required BuildContext context,
  required Widget child,
  BottomSheetDialog bottomSheetDialog = BottomSheetDialog.Dialog,
}) {
  if (bottomSheetDialog == BottomSheetDialog.BottomSheet) {
    // Show a bottom sheet.
    return showModalBottomSheet(context: context, builder: (_) => child);
  } else {
    // Show a dialog.
    return showInDialog(context, builder: (_) => child);
  }
}

/// Retrieves package information asynchronously.
Future<PackageInfoData> getPackageInfo() async {
  if (isAndroid || isIOS) {
    var data = await invokeNativeMethod(channelName, 'packageInfo');

    if (data != null && data is Map) {
      // Parse package info data from native method result.
      return PackageInfoData(
        appName: data['appName'],
        packageName: data['packageName'],
        versionName: data['versionName'],
        versionCode: data['versionCode'],
        androidSDKVersion: data['androidSDKVersion'],
      );
    } else {
      // Throw an error if data retrieval fails.
      throw errorSomethingWentWrong;
    }
  } else {
    // Return empty package info for unsupported platforms.
    return PackageInfoData();
  }
}

/// Get Package Name
Future<String> getPackageName() async {
  return (await getPackageInfo()).packageName.validate();
}

/// mailto: function to open native email app
Uri mailTo({
  required List<String> to,
  String subject = '',
  String body = '',
  List<String> cc = const [],
  List<String> bcc = const [],
}) {
  String _subject = '';
  if (subject.isNotEmpty) _subject = '&subject=$subject';

  String _body = '';
  if (body.isNotEmpty) _body = '&body=$body';

  String _cc = '';
  if (cc.isNotEmpty) _cc = '&cc=${cc.join(',')}';

  String _bcc = '';
  if (bcc.isNotEmpty) _bcc = '&bcc=${bcc.join(',')}';

  return Uri(
    scheme: 'mailto',
    query: 'to=${to.join(',')}$_subject$_body$_cc$_bcc',
  );
}

/// Use this if you want to skip splash delay above Android 12
Future<void> splashDelay({int second = 2}) async {
  if (await isAndroid12Above()) {
    await 300.milliseconds.delay;
  } else {
    await second.seconds.delay;
  }
}
