library nb_utils;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_utils/src/models/LanguageDataModel.dart';
import 'package:nb_utils/src/utils/colors.dart';
import 'package:nb_utils/src/utils/constants.dart';
import 'package:nb_utils/src/utils/decorations.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:connectivity/connectivity.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:shared_preferences/shared_preferences.dart';

export 'src/LiveStream.dart';
export 'src/customPaints/google_logo_painter.dart';
export 'src/deprecated_widgets.dart';
export 'src/extensions/bool_extensions.dart';
export 'src/extensions/color_extensions.dart';
export 'src/extensions/context_extensions.dart';
export 'src/extensions/device_extensions.dart';
export 'src/extensions/double_extensions.dart';
export 'src/extensions/duration_extensions.dart';
export 'src/extensions/int_extensions.dart';
export 'src/extensions/list_extensions.dart';
export 'src/extensions/num_extensions.dart';
export 'src/extensions/scroll_extensions.dart';
export 'src/extensions/string_extensions.dart';
export 'src/extensions/string_extensions.dart';
export 'src/extensions/widget_extensions.dart';
export 'src/models/LanguageDataModel.dart';
export 'src/models/WalkThroughModel.dart';
export 'src/utils/after_layout.dart';
export 'src/utils/colors.dart';
export 'src/utils/common.dart';
export 'src/utils/constants.dart';
export 'src/utils/date_time_utils.dart';
export 'src/utils/decorations.dart';
export 'src/utils/jwt_decoder.dart';
export 'src/utils/network_utils.dart';
export 'src/utils/pattern.dart';
export 'src/utils/shared_pref.dart';
export 'src/utils/system_utils.dart';
export 'src/utils/text_styles.dart';
export 'src/utils/time_formatter.dart';
export 'src/widgets/AppButton.dart';
export 'src/widgets/AppTextField.dart';
export 'src/widgets/CircularProgressGradient.dart';
export 'src/widgets/ConfirmationDialog.dart';
export 'src/widgets/DotIndicator.dart';
export 'src/widgets/DottedBorderWidget.dart';
export 'src/widgets/GradientBorder.dart';
export 'src/widgets/HorizontalList.dart';
export 'src/widgets/HoverWidget.dart';
export 'src/widgets/LanguageListWidget.dart';
export 'src/widgets/Loader.dart';
export 'src/widgets/Marquee.dart';
export 'src/widgets/OverlayCustomWidget.dart';
export 'src/widgets/PersistentTabs.dart';
export 'src/widgets/RatingBarWidget.dart';
export 'src/widgets/Responsive.dart';
export 'src/widgets/RichTextWidget.dart';
export 'src/widgets/SettingItemWidget.dart';
export 'src/widgets/SettingSection.dart';
export 'src/widgets/SnapHelperWidget.dart';
export 'src/widgets/TextIcon.dart';
export 'src/widgets/ThemeWidget.dart';
export 'src/widgets/ULWidget.dart';
export 'src/widgets/widgets.dart';
export 'src/widgets/GradientBorder.dart';

//region Global variables - This variables can be changed.
Color textPrimaryColorGlobal = textPrimaryColor;
Color textSecondaryColorGlobal = textSecondaryColor;
double textBoldSizeGlobal = 16;
double textPrimarySizeGlobal = 16;
double textSecondarySizeGlobal = 14;
String? fontFamilyBoldGlobal;
String? fontFamilyPrimaryGlobal;
String? fontFamilySecondaryGlobal;
FontWeight fontWeightBoldGlobal = FontWeight.bold;
FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
FontWeight fontWeightSecondaryGlobal = FontWeight.normal;

Color appBarBackgroundColorGlobal = Colors.white;
Color appButtonBackgroundColorGlobal = Colors.white;
Color defaultAppButtonTextColorGlobal = textPrimaryColorGlobal;
double defaultAppButtonRadius = 8.0;
double defaultAppButtonElevation = 4.0;
bool enableAppButtonScaleAnimationGlobal = true;
int? appButtonScaleAnimationDurationGlobal;
ShapeBorder? defaultAppButtonShapeBorder;

Color defaultLoaderBgColorGlobal = Colors.white;
Color? defaultLoaderAccentColorGlobal;

Color? defaultInkWellSplashColor;
Color? defaultInkWellHoverColor;
Color? defaultInkWellHighlightColor;
double? defaultInkWellRadius;

Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
int defaultElevation = 4;
double defaultRadius = 8.0;
double defaultBlurRadius = 4.0;
double defaultSpreadRadius = 1.0;
double defaultAppBarElevation = 4.0;

double tabletBreakpointGlobal = 600.0;
double desktopBreakpointGlobal = 720.0;

int passwordLengthGlobal = 6;

late SharedPreferences sharedPreferences;

ShapeBorder? defaultDialogShape;

String defaultCurrencySymbol = currencyRupee;

LanguageDataModel? selectedLanguageDataModel;
List<LanguageDataModel> localeLanguageList = [];

// Toast Config
Color defaultToastBackgroundColor = Colors.grey.shade200;
Color defaultToastTextColor = Colors.black;
ToastGravity defaultToastGravityGlobal = ToastGravity.CENTER;
BorderRadius defaultToastBorderRadiusGlobal = radius(30);
//endregion

// Must be initialize before using shared preference
Future<void> initialize({
  double? defaultDialogBorderRadius,
  List<LanguageDataModel>? aLocaleLanguageList,
}) async {
  sharedPreferences = await SharedPreferences.getInstance();

  defaultAppButtonShapeBorder =
      RoundedRectangleBorder(borderRadius: radius(defaultAppButtonRadius));

  defaultDialogShape = dialogShape(defaultDialogBorderRadius);

  localeLanguageList = aLocaleLanguageList ?? [];

  selectedLanguageDataModel = getSelectedLanguageModel();
}

class NBUtils {
  static const MethodChannel _channel = const MethodChannel('nb_utils');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
