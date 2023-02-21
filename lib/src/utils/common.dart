import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

/// Make any variable nullable
T? makeNullable<T>(T? value) => value;

/// Enum for page route
enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }

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
      decoration: BoxDecoration(
        color: bgColor ?? defaultToastBackgroundColor,
        boxShadow: defaultBoxShadow(),
        borderRadius: borderRadius ?? defaultToastBorderRadiusGlobal,
      ),
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: Text(text.validate(),
          style: boldTextStyle(color: textColor ?? defaultToastTextColor)),
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
              padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
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
  return data?.text?.toString() ?? '';
}

/// Returns a string from Clipboard
Future<dynamic> pasteObject() async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  return data;
}

/// Enum for Link Provider
enum LinkProvider {
  playStore,
  appStore,
  facebook,
  instagram,
  linkedIn,
  twitter,
  youTube,
  reddit,
  telegram,
  whatsapp,
  facebookMessenger,
  googleDrive
}

/// Use getSocialMediaLink function to build social media links
String getSocialMediaLink(LinkProvider linkProvider, {String url = ''}) {
  switch (linkProvider) {
    case LinkProvider.playStore:
      return '$playStoreBaseURL$url';
    case LinkProvider.appStore:
      return '$appStoreBaseURL$url';
    case LinkProvider.facebook:
      return '$facebookBaseURL$url';
    case LinkProvider.instagram:
      return '$instagramBaseURL$url';
    case LinkProvider.linkedIn:
      return '$linkedinBaseURL$url';
    case LinkProvider.twitter:
      return '$twitterBaseURL$url';
    case LinkProvider.youTube:
      return '$youtubeBaseURL$url';
    case LinkProvider.reddit:
      return '$redditBaseURL$url';
    case LinkProvider.telegram:
      return '$telegramBaseURL$url';
    case LinkProvider.facebookMessenger:
      return '$facebookMessengerURL$url';
    case LinkProvider.whatsapp:
      return '$whatsappURL$url';
    case LinkProvider.googleDrive:
      return '$googleDriveURL$url';
  }
}

const double degrees2Radians = pi / 180.0;

double radians(double degrees) => degrees * degrees2Radians;

void afterBuildCreated(Function()? onCreated) {
  makeNullable(SchedulerBinding.instance)!
      .addPostFrameCallback((_) => onCreated?.call());
}

Widget dialogAnimatedWrapperWidget({
  required Animation<double> animation,
  required Widget child,
  required DialogAnimation dialogAnimation,
  required Curve curve,
}) {
  switch (dialogAnimation) {
    case DialogAnimation.rotate:
      return Transform.rotate(
        angle: radians(animation.value * 360),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.slideTopBottom:
      final curvedValue = curve.transform(animation.value) - 1.0;

      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 300, 0.0),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.scale:
      return Transform.scale(
        scale: animation.value,
        child: FadeTransition(opacity: animation, child: child),
      );

    case DialogAnimation.slideBottomTop:
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.slideLeftRight:
      return SlideTransition(
        position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.slideRightLet:
      return SlideTransition(
        position: Tween(begin: const Offset(-1, 0), end: Offset.zero)
            .chain(CurveTween(curve: curve))
            .animate(animation),
        child: Opacity(
          opacity: animation.value,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );

    case DialogAnimation.defaultAnimation:
      return FadeTransition(opacity: animation, child: child);
  }
}

Route<T> buildPageRoute<T>(
  Widget child,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
) {
  if (pageRouteAnimation != null) {
    if (pageRouteAnimation == PageRouteAnimation.fade) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.rotate) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return RotationTransition(
              turns: ReverseAnimation(anim), child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.scale) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return ScaleTransition(scale: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.slide) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(anim),
            child: child,
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.slideBottomTop) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(anim),
            child: child,
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    }
  }
  return MaterialPageRoute<T>(builder: (_) => child);
}

EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  if (context.isDesktop()) {
    return const EdgeInsets.symmetric(vertical: 20, horizontal: 20);
  } else if (context.isTablet()) {
    return const EdgeInsets.symmetric(vertical: 16, horizontal: 16);
  } else {
    return const EdgeInsets.symmetric(vertical: 14, horizontal: 16);
  }
}

enum BottomSheetDialog { dialog, bottomSheet }

Future<dynamic> showBottomSheetOrDialog({
  required BuildContext context,
  required Widget child,
  BottomSheetDialog bottomSheetDialog = BottomSheetDialog.dialog,
}) {
  if (bottomSheetDialog == BottomSheetDialog.bottomSheet) {
    return showModalBottomSheet(context: context, builder: (_) => child);
  } else {
    return showInDialog(context, builder: (_) => child);
  }
}

Future<PackageInfoData> getPackageInfo() async {
  if (isAndroid || isIOS) {
    var data = await invokeNativeMethod(channelName, 'packageInfo');

    if (data != null && data is Map) {
      return PackageInfoData(
        appName: data['appName'],
        packageName: data['packageName'],
        versionName: data['versionName'],
        versionCode: data['versionCode'],
        androidSDKVersion: data['androidSDKVersion'],
      );
    } else {
      throw errorSomethingWentWrong;
    }
  } else {
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
  String subject0 = '';
  if (subject.isNotEmpty) subject0 = '&subject=$subject';

  String body0 = '';
  if (body.isNotEmpty) body0 = '&body=$body';

  String cc0 = '';
  if (cc.isNotEmpty) cc0 = '&cc=${cc.join(',')}';

  String bcc0 = '';
  if (bcc.isNotEmpty) bcc0 = '&bcc=${bcc.join(',')}';

  return Uri(
    scheme: 'mailto',
    query: 'to=${to.join(',')}$subject0$body0$cc0$bcc0',
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
