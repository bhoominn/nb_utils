import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/utils/common.dart';
import 'package:nb_utils/src/utils/text_styles.dart';
import 'package:nb_utils/src/widgets/ConfirmationDialog.dart';
import 'package:nb_utils/src/widgets/Loader.dart';

/// show confirm dialog box
Future<bool?> showConfirmDialog<bool>(
  context,
  String title, {
  String positiveText = 'Yes',
  String negativeText = 'No',
  Color? buttonColor,
  Color? barrierColor,
  DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
  bool? barrierDismissible,
  Function? onAccept,
}) async {
  return await showGeneralDialog(
    context: context,
    // barrierDismissible: barrierDismissible == null ? false : true,
    barrierColor: barrierColor ?? Color(0x80000000),
    barrierLabel: '',
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => Container(),
    transitionBuilder: (_, animation, secondaryAnimation, child) {
      return dialogAnimatedWrapperWidget(
        animation: animation,
        dialogAnimation: dialogAnimation,
        child: AlertDialog(
          title: Text(title.validate(), style: primaryTextStyle()),
          actions: <Widget>[
            SimpleDialogOption(
              child: Text(negativeText.validate(), style: secondaryTextStyle()),
              onPressed: () {
                finish(_, false);
              },
            ),
            SimpleDialogOption(
              onPressed: () {
                finish(_, true);
                onAccept?.call();
              },
              child: Text(positiveText.validate(),
                  style: primaryTextStyle(
                      color: buttonColor ?? Theme.of(_).primaryColor)),
            ),
          ],
        ),
      );
    },
  );
}

/// show child widget in dialog
Future<T?> showInDialog<T>(
  BuildContext context, {
  Widget? title,
  @Deprecated('Use builder instead') Widget? child,
  Widget? Function(BuildContext)? builder,
  ShapeBorder? shape,
  TextStyle? titleTextStyle,
  EdgeInsetsGeometry? contentPadding,
  //bool scrollable = false,
  Color? backgroundColor,
  double? elevation,
  //EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  List<Widget>? actions,
  bool barrierDismissible = true,
}) async {
  return await showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      content: builder != null ? builder.call(_) : child,
      shape: shape ?? defaultDialogShape,
      title: title,
      titleTextStyle: titleTextStyle,
      contentPadding:
          contentPadding ?? EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      //scrollable: scrollable,
      backgroundColor: backgroundColor,
      elevation: elevation ?? 0,
      //insetPadding: insetPadding,
      actions: actions,
    ),
  );
}

/// Default AppBar
AppBar appBarWidget(
  String title, {
  @Deprecated('Use titleWidget instead') Widget? child,
  Widget? titleWidget,
  List<Widget>? actions,
  Color? color,
  bool center = false,
  Color? textColor,
  int textSize = 20,
  bool showBack = true,
  Color? shadowColor,
  double? elevation,
  Widget? backWidget,
  Brightness? brightness,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  TextStyle? titleTextStyle,
  PreferredSizeWidget? bottom,
  Widget? flexibleSpace,
}) {
  return AppBar(
    centerTitle: center,
    title: titleWidget ??
        Text(
          title,
          style: titleTextStyle ??
              (boldTextStyle(
                  color: textColor ?? textPrimaryColorGlobal, size: textSize)),
        ),
    actions: actions,
    automaticallyImplyLeading: showBack,
    backgroundColor: color ?? appBarBackgroundColorGlobal,
    leading: showBack
        ? (backWidget ?? BackButton(color: textColor ?? textPrimaryColorGlobal))
        : null,
    shadowColor: shadowColor,
    elevation: elevation ?? defaultAppBarElevation,
    brightness: brightness,
    systemOverlayStyle: systemUiOverlayStyle,
    bottom: bottom,
    flexibleSpace: flexibleSpace,
  );
}

/// Handle error and loading widget when using FutureBuilder or StreamBuilder
Widget snapWidgetHelper<T>(
  AsyncSnapshot<T> snap, {
  Widget? errorWidget,
  Widget? loadingWidget,
  String? defaultErrorMessage,
  @Deprecated('Do not use this') bool checkHasData = false,
}) {
  if (snap.hasError) {
    log(snap.error);
    return errorWidget ??
        Text(
          defaultErrorMessage ?? snap.error.toString(),
          style: primaryTextStyle(),
        ).center();
  } else if (!snap.hasData) {
    return loadingWidget ?? Loader();
  } else {
    return SizedBox();
  }
}

/// Returns true is snapshot is loading
bool isSnapshotLoading(AsyncSnapshot snap, {bool checkHasData = false}) {
  return snap.connectionState == ConnectionState.active ||
      snap.connectionState == ConnectionState.waiting;
}
