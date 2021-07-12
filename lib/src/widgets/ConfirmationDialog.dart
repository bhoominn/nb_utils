import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/utils/text_styles.dart';
import 'package:vector_math/vector_math.dart' as math;

enum DialogType { CONFIRMATION, ACCEPT, DELETE, UPDATE, ADD, RETRY }
enum DialogAnimation { DEFAULT, ROTATE, SLIDE_TB, SLIDE_BT, SLIDE_LR, SLIDE_RL, SCALE }

Color getDialogPrimaryColor(BuildContext context, DialogType dialogType, Color? primaryColor) {
  if (primaryColor != null) return primaryColor;
  Color color;

  switch (dialogType) {
    case DialogType.DELETE:
      color = Colors.red;
      break;
    case DialogType.UPDATE:
      color = Colors.amber;
      break;
    case DialogType.CONFIRMATION:
    case DialogType.ADD:
    case DialogType.RETRY:
      color = Colors.blue;
      break;
    case DialogType.ACCEPT:
      color = Colors.green;
      break;
  }
  return color;
}

String getPositiveText(DialogType dialogType) {
  String positiveText = "";

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      positiveText = "Yes";
      break;
    case DialogType.DELETE:
      positiveText = "Delete";
      break;
    case DialogType.UPDATE:
      positiveText = "Update";
      break;
    case DialogType.ADD:
      positiveText = "Add";
      break;
    case DialogType.ACCEPT:
      positiveText = "Accept";
      break;
    case DialogType.RETRY:
      positiveText = "Retry";
      break;
  }
  return positiveText;
}

String getTitle(DialogType dialogType) {
  String titleText = "";

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      titleText = "Are you sure want to perform this action?";
      break;
    case DialogType.DELETE:
      titleText = "Do you want to delete?";
      break;
    case DialogType.UPDATE:
      titleText = "Do you want to update?";
      break;
    case DialogType.ADD:
      titleText = "Do you want to add?";
      break;
    case DialogType.ACCEPT:
      titleText = "Do you want to accept?";
      break;
    case DialogType.RETRY:
      titleText = "Click to retry";
      break;
  }
  return titleText;
}

Widget getIcon(DialogType dialogType, {double? size}) {
  Icon icon;

  switch (dialogType) {
    case DialogType.CONFIRMATION:
    case DialogType.RETRY:
    case DialogType.ACCEPT:
      icon = Icon(Icons.done, size: size ?? 20, color: Colors.white);
      break;
    case DialogType.DELETE:
      icon = Icon(Icons.delete_forever_outlined, size: size ?? 20, color: Colors.white);
      break;
    case DialogType.UPDATE:
      icon = Icon(Icons.edit, size: size ?? 20, color: Colors.white);
      break;
    case DialogType.ADD:
      icon = Icon(Icons.add, size: size ?? 20, color: Colors.white);
      break;
  }
  return icon;
}

Widget? getCenteredImage(BuildContext context, DialogType dialogType, Color? primaryColor) {
  Widget? widget;

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(context, dialogType, primaryColor).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.warning_amber_rounded, color: getDialogPrimaryColor(context, dialogType, primaryColor), size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.DELETE:
      widget = Container(
        decoration: BoxDecoration(color: getDialogPrimaryColor(context, dialogType, primaryColor).withOpacity(0.2), shape: BoxShape.circle),
        child: Icon(Icons.close, color: getDialogPrimaryColor(context, dialogType, primaryColor), size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.UPDATE:
      widget = Container(
        decoration: BoxDecoration(color: getDialogPrimaryColor(context, dialogType, primaryColor).withOpacity(0.2), shape: BoxShape.circle),
        child: Icon(Icons.edit_outlined, color: getDialogPrimaryColor(context, dialogType, primaryColor), size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.ADD:
    case DialogType.ACCEPT:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(context, dialogType, primaryColor).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.done_outline, color: getDialogPrimaryColor(context, dialogType, primaryColor), size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.RETRY:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(context, dialogType, primaryColor).withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.refresh_rounded, color: getDialogPrimaryColor(context, dialogType, primaryColor), size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
  }
  return widget;
}

Widget defaultPlaceHolder(
  BuildContext context,
  DialogType dialogType,
  double? height,
  double? width,
  Color? primaryColor, {
  Widget? child,
}) {
  return Container(
    color: getDialogPrimaryColor(context, dialogType, primaryColor).withOpacity(0.2),
    height: height,
    width: width,
    alignment: Alignment.center,
    child: child ?? getCenteredImage(context, dialogType, primaryColor),
  );
}

Widget buildTitleWidget(
  BuildContext context,
  DialogType dialogType,
  Color? primaryColor,
  Widget? customCenterWidget,
  double height,
  double width,
  String? centerImage,
) {
  if (customCenterWidget != null) {
    return Container(
      child: customCenterWidget,
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
    );
  } else {
    if (centerImage != null) {
      return Image.network(
        centerImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (_, object, stack) {
          log(object.toString());
          return defaultPlaceHolder(context, dialogType, height, width, primaryColor);
        },
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return defaultPlaceHolder(
            context,
            dialogType,
            height,
            width,
            primaryColor,
            child: Loader(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
            ),
          );
        },
      ).cornerRadiusWithClipRRectOnly(topLeft: defaultRadius.toInt(), topRight: defaultRadius.toInt());
    } else {
      return defaultPlaceHolder(
        context,
        dialogType,
        height,
        width,
        primaryColor,
      );
    }
  }
}

/// show confirm dialog box
Future<bool?> showConfirmDialogCustom(
  BuildContext context, {
  String? title,
  String? subTitle,
  String? positiveText,
  String? negativeText,
  String? centerImage,
  Widget? customCenterWidget,
  Color? primaryColor,
  ShapeBorder? shape,

  /// Use as function
  required Function(BuildContext) onAccept,
  Function(BuildContext)? onCancel,
  DialogType dialogType = DialogType.CONFIRMATION,
  DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
  bool barrierDismissible = true,
  double height = 140,
  Color? barrierColor,
  double width = 220,
  bool cancelable = true,
}) async {
  return showGeneralDialog(
    context: context,
    barrierColor: barrierColor ?? Color(0x80000000),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (_, animation, secondaryAnimation, child) {
      return customWidget(
        animation: animation,
        dialogAnimation: dialogAnimation,
        child: AlertDialog(
          shape: shape ?? dialogShape(),
          titlePadding: EdgeInsets.zero,
          backgroundColor: _.cardColor,
          title: Container(
            child: buildTitleWidget(
              _,
              dialogType,
              primaryColor,
              customCenterWidget,
              height,
              width,
              centerImage,
            ),
          ),
          content: Container(
            width: width,
            color: _.cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? getTitle(dialogType),
                  style: boldTextStyle(size: 16),
                  textAlign: TextAlign.center,
                ),
                8.height.visible(subTitle.validate().isNotEmpty),
                Text(
                  subTitle.validate(),
                  style: secondaryTextStyle(size: 16),
                  textAlign: TextAlign.center,
                ).visible(subTitle.validate().isNotEmpty),
                16.height,
                Row(
                  children: [
                    AppButton(
                      elevation: 0,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: radius(defaultAppButtonRadius),
                        side: BorderSide(color: viewLineColor),
                      ),
                      color: _.scaffoldBackgroundColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.close, color: textPrimaryColorGlobal, size: 20),
                          6.width,
                          Text(
                            negativeText ?? 'Cancel',
                            style: boldTextStyle(color: textPrimaryColorGlobal),
                          ),
                        ],
                      ).fit(),
                      onTap: () {
                        if (cancelable) finish(_, false);

                        onCancel?.call(_);
                      },
                    ).expand(),
                    16.width,
                    AppButton(
                      elevation: 0,
                      color: getDialogPrimaryColor(_, dialogType, primaryColor),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getIcon(dialogType),
                          6.width,
                          Text(
                            positiveText ?? getPositiveText(dialogType),
                            style: boldTextStyle(color: Colors.white),
                          ),
                        ],
                      ).fit(),
                      onTap: () {
                        onAccept.call(_);

                        if (cancelable) finish(_, true);
                      },
                    ).expand(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      shape: shape ?? dialogShape(),
      titlePadding: EdgeInsets.zero,
      backgroundColor: _.cardColor,
      title: Container(
        child: buildTitleWidget(
          _,
          dialogType,
          primaryColor,
          customCenterWidget,
          height,
          width,
          centerImage,
        ),
      ),
      content: Container(
        width: width,
        color: _.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? getTitle(dialogType),
              style: boldTextStyle(size: 16),
              textAlign: TextAlign.center,
            ),
            8.height.visible(subTitle.validate().isNotEmpty),
            Text(
              subTitle.validate(),
              style: secondaryTextStyle(size: 16),
              textAlign: TextAlign.center,
            ).visible(subTitle.validate().isNotEmpty),
            16.height,
            Row(
              children: [
                AppButton(
                  elevation: 0,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: radius(defaultAppButtonRadius),
                    side: BorderSide(color: viewLineColor),
                  ),
                  color: _.scaffoldBackgroundColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.close, color: textPrimaryColorGlobal, size: 20),
                      6.width,
                      Text(
                        negativeText ?? 'Cancel',
                        style: boldTextStyle(color: textPrimaryColorGlobal),
                      ),
                    ],
                  ).fit(),
                  onTap: () {
                    if (cancelable) finish(_, false);

                    onCancel?.call(_);
                  },
                ).expand(),
                16.width,
                AppButton(
                  elevation: 0,
                  color: getDialogPrimaryColor(_, dialogType, primaryColor),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getIcon(dialogType),
                      6.width,
                      Text(
                        positiveText ?? getPositiveText(dialogType),
                        style: boldTextStyle(color: Colors.white),
                      ),
                    ],
                  ).fit(),
                  onTap: () {
                    onAccept.call(_);

                    if (cancelable) finish(_, true);
                  },
                ).expand(),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget customWidget({required Animation<double> animation, required Widget child, required DialogAnimation dialogAnimation}) {
  switch (dialogAnimation) {
    case DialogAnimation.ROTATE:
      return Transform.rotate(
        angle: math.radians(animation.value * 360),
        child: Opacity(opacity: animation.value, child: child),
      );
    case DialogAnimation.SLIDE_TB:
      final curvedValue = Curves.easeInOutBack.transform(animation.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(opacity: animation.value, child: child),
      );
    case DialogAnimation.SCALE:
      return Transform.scale(
        scale: animation.value,
        child: child,
      );
    case DialogAnimation.SLIDE_BT:
      return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutBack,
          )),
          child: Opacity(opacity: animation.value, child: child));
    case DialogAnimation.SLIDE_LR:
      return SlideTransition(
          position: Tween(begin: Offset(-0.5, 0.0), end: Offset(0, 0)).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutBack,
          )),
          child: Opacity(opacity: animation.value, child: child));
    case DialogAnimation.SLIDE_RL:
      return SlideTransition(
          position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutBack,
          )),
          child: Opacity(opacity: animation.value, child: child));
    case DialogAnimation.DEFAULT:
      return child;
  }
}
