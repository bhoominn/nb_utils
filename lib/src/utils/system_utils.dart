import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/src/extensions/color_extensions.dart';
import 'package:nb_utils/src/extensions/device_extensions.dart';

/// Go back to previous screen.
void finish(BuildContext context, [Object? result]) =>
    Navigator.pop(context, result);

/// Go to new screen with provided screen tag.
///
/// ```dart
/// launchNewScreen(context, '/HomePage');
/// ```
Future<T?> launchNewScreen<T>(BuildContext context, String tag) async =>
    Navigator.of(context).pushNamed(tag);

/// Removes all previous screens from the back stack and redirect to new screen with provided screen tag
///
/// ```dart
/// launchNewScreenWithNewTask(context, '/HomePage');
/// ```
Future<T?> launchNewScreenWithNewTask<T>(
        BuildContext context, String tag) async =>
    Navigator.of(context).pushNamedAndRemoveUntil(tag, (r) => false);

/// Change status bar Color and Brightness
Future<void> setStatusBarColor(
  Color statusBarColor, {
  Color? systemNavigationBarColor,
  Brightness? statusBarBrightness,
  Brightness? statusBarIconBrightness,
  int delayInMilliSeconds = 200,
}) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ??
          (statusBarColor.isDark() ? Brightness.light : Brightness.dark),
    ),
  );
}

/// This function will show status bar
Future<void> showStatusBar() async {
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

/// This function will hide status bar
Future<void> hideStatusBar() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
}

/// Set orientation to portrait
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Set orientation to landscape
void setOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

/// Returns current PlatformName
String platformName() {
  if (isLinux) return 'Linux';
  if (isWeb) return 'Web';
  if (isMacOS) return 'macOS';
  if (isWindows) return 'Windows';
  if (isAndroid) return 'Android';
  if (isIos) return 'iOS';
  return '';
}

/// Custom scroll behaviour
Widget Function(BuildContext, Widget?)? scrollBehaviour() {
  return (context, child) {
    return ScrollConfiguration(behavior: SBehavior(), child: child!);
  };
}

/// Custom scroll behaviour widget
class SBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// Invoke Native method and get result
Future<T?> invokeNativeMethod<T>(String channel, String method,
    [dynamic arguments]) async {
  var platform = MethodChannel(channel);
  return await platform.invokeMethod<T>(method, arguments);
}

/// Prints only if in debug or profile mode
void log(Object? value) {
  if (!kReleaseMode) print(value);
}
