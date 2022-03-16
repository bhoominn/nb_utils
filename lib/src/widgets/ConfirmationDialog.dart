import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum DialogType { CONFIRMATION, ACCEPT, DELETE, UPDATE, ADD, RETRY }

enum DialogAnimation {
  DEFAULT,
  ROTATE,
  SLIDE_TOP_BOTTOM,
  SLIDE_BOTTOM_TOP,
  SLIDE_LEFT_RIGHT,
  SLIDE_RIGHT_LEFT,
  SCALE
}

Color getDialogPrimaryColor(
  BuildContext context,
  DialogType dialogType,
  Color? primaryColor,
) {
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
      icon = Icon(Icons.delete_forever_outlined,
          size: size ?? 20, color: Colors.white);
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

Widget? getCenteredImage(
    BuildContext context, DialogType dialogType, Color? primaryColor) {
  Widget? widget;

  switch (dialogType) {
    case DialogType.CONFIRMATION:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(context, dialogType, primaryColor)
              .withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.warning_amber_rounded,
            color: getDialogPrimaryColor(context, dialogType, primaryColor),
            size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.DELETE:
      widget = Container(
        decoration: BoxDecoration(
            color: getDialogPrimaryColor(context, dialogType, primaryColor)
                .withOpacity(0.2),
            shape: BoxShape.circle),
        child: Icon(Icons.close,
            color: getDialogPrimaryColor(context, dialogType, primaryColor),
            size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.UPDATE:
      widget = Container(
        decoration: BoxDecoration(
            color: getDialogPrimaryColor(context, dialogType, primaryColor)
                .withOpacity(0.2),
            shape: BoxShape.circle),
        child: Icon(Icons.edit_outlined,
            color: getDialogPrimaryColor(context, dialogType, primaryColor),
            size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.ADD:
    case DialogType.ACCEPT:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(context, dialogType, primaryColor)
              .withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.done_outline,
            color: getDialogPrimaryColor(context, dialogType, primaryColor),
            size: 40),
        padding: EdgeInsets.all(16),
      );
      break;
    case DialogType.RETRY:
      widget = Container(
        decoration: BoxDecoration(
          color: getDialogPrimaryColor(context, dialogType, primaryColor)
              .withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.refresh_rounded,
            color: getDialogPrimaryColor(context, dialogType, primaryColor),
            size: 40),
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
  ShapeBorder? shape,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: getDialogPrimaryColor(context, dialogType, primaryColor)
          .withOpacity(0.2),
    ),
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
  ShapeBorder? shape,
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
          return defaultPlaceHolder(
              context, dialogType, height, width, primaryColor,
              shape: shape);
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
            shape: shape,
            child: Loader(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } else {
      return defaultPlaceHolder(
          context, dialogType, height, width, primaryColor,
          shape: shape);
    }
  }
}

/// show confirm dialog box
Future<bool?> showConfirmDialogCustom(
  BuildContext context, {
  required Function(BuildContext) onAccept,
  String? title,
  String? subTitle,
  String? positiveText,
  String? negativeText,
  String? centerImage,
  Widget? customCenterWidget,
  Color? primaryColor,
  Color? positiveTextColor,
  Color? negativeTextColor,
  ShapeBorder? shape,
  Function(BuildContext)? onCancel,
  bool barrierDismissible = true,
  double? height,
  double? width,
  bool cancelable = true,
  Color? barrierColor,
  DialogType dialogType = DialogType.CONFIRMATION,
  DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
  Duration? transitionDuration,
  Curve curve = Curves.easeInBack,
}) async {
  hideKeyboard(context);

  return await showGeneralDialog(
    context: context,
    barrierColor: barrierColor ?? Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    transitionDuration: transitionDuration ?? 400.milliseconds,
    transitionBuilder: (_, animation, secondaryAnimation, child) {
      return dialogAnimatedWrapperWidget(
        animation: animation,
        dialogAnimation: dialogAnimation,
        curve: curve,
        child: AlertDialog(
          shape: shape ?? dialogShape(),
          titlePadding: EdgeInsets.zero,
          backgroundColor: _.cardColor,
          elevation: defaultElevation.toDouble(),
          title: buildTitleWidget(
            _,
            dialogType,
            primaryColor,
            customCenterWidget,
            height ?? customDialogHeight,
            width ?? customDialogWidth,
            centerImage,
            shape,
          ).cornerRadiusWithClipRRectOnly(
              topLeft: defaultRadius.toInt(), topRight: defaultRadius.toInt()),
          content: Container(
            width: width ?? customDialogWidth,
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
                          Icon(
                            Icons.close,
                            color: textPrimaryColorGlobal,
                            size: 20,
                          ),
                          6.width,
                          Text(
                            negativeText ?? 'Cancel',
                            style: boldTextStyle(
                                color: negativeTextColor ??
                                    textPrimaryColorGlobal),
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
                            style: boldTextStyle(
                                color: positiveTextColor ?? Colors.white),
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
}
