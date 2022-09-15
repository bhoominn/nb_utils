<div align="center">
<a href="https://pub.dev/packages/nb_utils/"><img src="https://img.shields.io/pub/v/nb_utils.svg" /></a>
<a href="https://opensource.org/licenses/MIT" target="_blank"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"/></a>
<a href="https://opensource.org/licenses/Apache-2.0" target="_blank"><img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=102"/></a>
<a href="https://github.com/bhoominn/nb_utils/issues" target="_blank"><img alt="GitHub: bhoominn" src="https://img.shields.io/github/issues-raw/bhoominn/nb_utils?style=flat" /></a>
<img src="https://img.shields.io/github/last-commit/bhoominn/nb_utils" />

<a href="https://discord.com/channels/854023838136533063/854023838576672839" target="_blank"><img src="https://img.shields.io/discord/854023838136533063" /></a>
<a href="https://github.com/bhoominn"><img alt="GitHub: bhoominn" src="https://img.shields.io/github/followers/bhoominn?label=Follow&style=social" /></a>
<a href="https://github.com/bhoominn/nb_utils"><img src="https://img.shields.io/github/stars/bhoominn/nb_utils?style=social" /></a>

<a href="https://saythanks.io/to/bhoominn" target="_blank"><img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg"/></a>
<a href="https://github.com/sponsors/bhoominn"><img src="https://img.shields.io/github/sponsors/bhoominn" /></a>

<a href="https://www.buymeacoffee.com/bhoominn"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=bhoominn&button_colour=5F7FFF&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00"></a>

</div>

## Show some love and like to support the project

### Say Thanks Here
<a href="https://saythanks.io/to/bhoominn" target="_blank"><img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg"/></a>

### Follow Me on Twitter 
<a href="https://twitter.com/bhoominnaik" target="_blank"><img src="https://img.shields.io/twitter/follow/bhoominnaik?color=1DA1F2&label=Followers&logo=twitter" /></a>

## Platform Support

| Android | iOS | MacOS  | Web | Linux | Windows |
| :-----: | :-: | :---:  | :-: | :---: | :-----: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |  ✔️   |   ✔️   |

## Installation

Add this line to pubspec.yaml

```yaml
dependencies:
    nb_utils: <latest_version>
```

Import package

```dart
import 'package:nb_utils/nb_utils.dart';
```

Initialize nb_utils in main.dart file for initializing Shared Preferences and other variables.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  runApp(MyApp());
}
```

Now, add navigatorKey in your MaterialApp or CupertinoApp

```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  navigatorKey: navigatorKey,
  home: HomePage(),
);
```

## Featured on Google's Dev Library
<a href="https://devlibrary.withgoogle.com/products/flutter/repos/bhoominn-nb_utils" target="_blank">Checkout here</a>

<a href="https://devlibrary.withgoogle.com/authors" target="_blank">Dev Library Contributors</a>

## Contents

- [Useful Methods](#useful-methods-or-extensions-you-will-ever-need)
- [Use of TextStyle](#textstyles)
- [Shared Preference Example](#shared-preference-example)
- [MaterialYou Theme](#materialyou-theme)
- [Decorations](#decorations)
- [Widgets](#widgets)
- [Extensions](#extensions)
  - [String Extensions](#string-extensions)
  - [bool Extensions](#bool-extensions)
  - [Color Extensions](#color-extensions)
  - [BuildContext Extensions](#buildcontext-extensions)
  - [DateTime Extensions](#datetime-extensions---utils)
  - [Device Extensions](#device-extensions)
  - [double Extensions](#double-extensions)
  - [Duration Extensions](#duration-extensions)
  - [int Extensions](#int-extensions)
  - [List Extensions](#list-extensions)
  - [num Extensions](#num-extensions)
  - [ScrollController Extensions](#scrollcontroller-extensions)
  - [Widget Extensions](#widget-extensions)
- [System Methods](#systems-methods)
- [Network Utils](#network-utils)
- [JWT Decoder](#jwt-decoder)
- [Dialog](#show-dialogs)
- [Custom Dialogs](#custom-dialogs)

## Useful methods or extensions you will ever need
```dart
/// Open a new screen
HomePage().launch(context);

/// Animate the new page (Slide, Rotate, Scale, Fade)
HomePage().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);

/// Remove all screens from back stack and opens new screen
HomePage().launch(context, isNewTask: true);

// Returns to previous Screen
finish(context);

// Returns to previous Screen with a result
finish(context, object);

/// Toast a String
toast('This is a string');

/// Prints only if in debug or profile mode - (parameter is Object)
log('Your string');

void hideKeyboard(context)

/// If you are opening Dialog in initState method and you want to use BuildContext but yet it is not created,
/// You can use afterBuildLayout in initState method like this.
afterBuildLayout(() {
  // Get Callback after your build widget is rendered
});

/// Get Package Name from Native Platform (Android, iOS)
await getPackageName();

/// Get Package Name, Version Code, Version Name (Android, iOS)
await getPackageInfo();

/// Return true if Android OS version is above 12
Future<bool> isAndroid12Above()

///  Handle error and loading widget when using FutureBuilder or StreamBuilder
/// "snap" is the snapShot value we get from FutureBuilder or StreamBuilder
return snapWidgetHelper(snap);

/// See the example below. You can Use FutureBuilder or StreamBuilder.
FutureBuilder(
  builder(_, snap) {
    if (snap.hasData) {
      return YourWidget();
    } else {
      /// This function will handle loading and error automatically.
      /// You can modify loading and error widget in parameters.
  
      return snapWidgetHelper(snap);
    }
  }
),

// Basic SnackBar
snackBar(context, title: 'Sample toast'),

// Enhanced
snackBar(
  context,
  title: 'Sample toast',
  textColor: Colors.blue,
  backgroundColor: Colors.white,
  elevation: 8,
  shape: RoundedRectangleBorder(borderRadius: radius(30)),
  margin: EdgeInsets.all(16),
  duration: 3.seconds,
);
```

## TextStyles
```dart
/// Apply Bold TextStyle
Text(item.title.validate(), style: boldTextStyle()),
    
/// Apply Primary TextStyle
Text(item.title.validate(), style: primaryTextStyle()),
    
/// Apply Secondary TextStyle
Text(item.title.validate(), style: secondaryTextStyle()),
```

## Shared Preference Example
```dart
/// To use SharedPreference, you must call initialize() method in main.dart file as mentioned in Installations section

/// setValue method has (String key, dynamic value) parameters

/// add a Double in SharedPref
await setValue("key", 20.0);

/// add a bool in SharedPref
await setValue("key", false);

/// add a int in SharedPref
await setValue("key", 10);

/// add a String in SharedPref
await setValue("key", "value");

/// add a String List in SharedPref
await setValue("key", ['value', 'value', 'value']);

/// Returns a Bool if exists in SharedPref
/// You can set a default value if it returns null
getBoolAsync("key");

/// Returns a Double if exists in SharedPref
getDoubleAsync("key");

/// Returns a Int if exists in SharedPref
getIntAsync("key");

/// Returns a String if exists in SharedPref
getStringAsync("key");

/// Returns a JSON if exists in SharedPref
getJSONAsync("key");

/// Remove a key from SharedPref
await removeKey("key");

/// Returns List of Keys that matches with given Key
getMatchingSharedPrefKeys('key')
```

## MaterialYou Theme
```dart
Future<dynamic> getMaterialYouColors()
Future<Color> getMaterialYouPrimaryColor()
```

## Decorations
```dart

BorderRadius radius([double? radius])
Radius radiusCircular([double? radius])
BorderRadius radiusOnly({double? topRight,double? topLeft,double? bottomRight,double? bottomLeft,})

ShapeBorder dialogShape([double? borderRadius])

/// Apply default BoxDecoration with default shadow and border radius
Container(
    decoration: boxDecorationDefault(), // You can modify based on your preference
),

InputDecoration defaultInputDecoration({String? hint, String? label, TextStyle? textStyle})
```

## Widgets
```dart
/// Give Blur effect to any widget
/// Use Blur widget to know more properies
Blur(
  child: AnyWidget(),
)
```

```dart
/// Making an app for Web? You must have to perform something on mouse hover event.
/// Use HoverWidget to get your widget is being hovering or not
HoverWidget(
  builder: (_, isHovering) {
    return AnyWidget();
  },
),
```

```dart
/// Wrap MaterialApp Widget with RestartAppWidget
/// Use: RestartAppWidget.init(context);
/// Call above line any where to restart your Flutter app.
RestartAppWidget(
  child: MaterialApp(),
)
```

```dart
DoublePressBackWidget(
  child: AnyWidget(),
  message: 'Your message' // Optional
),
```

```dart
/// Add a Google Logo
/// Add size parameter for custom size - Default is 24
GoogleLogoWidget(),
```
[Image](#googlelogowidget)

```dart
/// You can use your preferred State Management technique
Loader().visible(mIsLoading),
```
[GIF](#loader-widget)

```dart
/// Read More Text Widget
/// Use ReadMoreText Widget in your project to get more familiar with other properties 
ReadMoreText(
  'Long Text',
),
```

```dart
/// Timer widget
TimerWidget(
  function: () {
    // Do something
  },
  child: Text('Your Widget'),
  duration: 10.seconds,
),
```

```dart
SettingSection(
  title: Text('Account Management', style: boldTextStyle(size: 24)),
  subTitle: Text('Control your account', style: primaryTextStyle()), // Optional
  items: [
    SettingItemWidget(
      title: 'Hibernate account',
      subTitle: 'Temporary deactivate your account',
      decoration: BoxDecoration(borderRadius: radius()),
      trailing: Icon(Icons.keyboard_arrow_right_rounded, color: context.dividerColor),
      onTap: () {
        //
      }
    ),
    SettingItemWidget(
      title: 'Close account',
      subTitle: 'Learn about your options, and close your account if you wish',
      decoration: BoxDecoration(borderRadius: radius()),
      trailing: Icon(Icons.keyboard_arrow_right_rounded, color: context.dividerColor),
      onTap: () {
        //
      },
    )
  ],
),
```
[Image](#settingsection)

```dart
//SettingItem
SettingItemWidget(
   title: "Title",
   onTap: () {
       //Your Logic
   },
   trailing: Icon(Icons.home_sharp), // Optional
   leading: Icon(Icons.arrow_forward_ios_rounded), // Optional
   subTitle: "Subtitle", // Optional
),
```
[Image](#settingitemwidget)

```dart
/// Default AppButton
/// Use AppButton on your app to try more properties
AppButton(
  text: "Submit",
  color: Colors.green, // Optional
  onTap: () {
      //Your logic
  },
),
```
[GIF](#appbutton)

```dart
/// Use PlaceHolderWidget while your network image is loading
PlaceHolderWidget(),
```

```dart
/// Use GradientBorder while your network image is loading
GradientBorder(
  gradient: LinearGradient(
    colors: [
      Colors.orange,
      Colors.yellow,
      Colors.pink,
    ],
  ),
  strokeWidth: 4.0,
  child: AnyWidget(),
)
```

```dart
/// Use RoundedCheckBox widget to get nicely rounded check box
/// It has many optional parameters to get personalized check box widget
RoundedCheckBox(
  isChecked: true,
  text: 'Remember me',
  onTap: (val) {
    //
  },
),
```

```dart
/// Use SizeListener widget to get callback when its child widget size changes
SizeListener(
  child: AnyWidget(),
  onSizeChange: (size) {
    log(size.width.toString());
  },
),
```

```dart
UL(
   symbolType: SymbolType.Numbered,
   children: [
       Text('Hi', style: primaryTextStyle()),
       Text('Hello', style: primaryTextStyle()),
       Text('How are you?', style: primaryTextStyle()),
   ],
),
```
[Image](#ul-widget)

```dart
/// Use AppTextField on your app to try more properties
/// Use Form Validate to validate all AppTextField

/// Inbuilt Email Validator, Automatic email keyboard type
AppTextField(
  controller: TextEditingController(), // Optional
  textFieldType: TextFieldType.EMAIL,
  decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
),

/// Default Min Lines 4
AppTextField(
  controller: TextEditingController(), // Optional
  textFieldType: TextFieldType.MULTILINE,
  decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
),

/// Automatic password obscure, Show/Hide Password Option
AppTextField(
  controller: TextEditingController(), // Optional
  textFieldType: TextFieldType.PASSWORD,
  decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
),
```
[Image](#apptextfield)

```dart
/// Add read more button to a long text
ReadMoreText(
  'Long Text',
),
```

```dart
/// Build Horizontal List widget without giving specific height to it.
HorizontalList(
  itemBuilder: (BuildContext context, int index) {
      return AnyWidget();
  },
  itemCount: 25,
),
```
[GIF](#horizontallist-widget)

```dart
RatingBarWidget(
  rating: initialRating,
  onRatingChanged: (aRating) {
      rating = aRating;
  },
),
```
[Image](#ratingbarwidget)

```dart
/// Make your Flutter App Responsive in any device out there with Responsive widget
Responsive(
  mobile: MobileWidget(),
  tablet: TabletWidget(), // Optional
  web: WebWidget(), // Optional
),
```
[Image](#responsive-widget)

```dart
TextIcon(
  text: 'Your text',
  prefix: AnyWidget(), // Optional
  suffix: AnyWidget(), // Optional
),
```

```dart
DotIndicator(
  pageController: pageController,
  pages: list,
),
```
[GIF](#dotindicator-widget)

```dart
/// Use SnapHelperWidget to handle loading and error widget automatically
/// Still you can specify custom Loader Widget and Error Widget
SnapHelperWidget<T>(
  future: future,
  onSuccess: (data) {
      return AnyWidget();
  },
),
```

```dart
DottedBorderWidget(
  child: Container(
      height: 100,
      width: 100,
  ),
),
```
[Image](#dottedborderwidget)

```dart
Marquee(
  direction: Axis.horizontal,
  animationDuration: Duration(milliseconds: 100),
  pauseDuration: Duration(milliseconds: 100),
  child: Text("Please enter a long text to see the effect of the marquee widget"),
),
```

# Extensions
## String Extensions
```dart
String validate({String value = ''})
bool validateEmail()
bool validatePhone()
bool validateURL()

bool isDigit()
bool isAlpha()
bool isJson()

bool get isInt
bool get isImage
bool get isAudio
bool get isVideo
bool get isTxt
bool get isDoc
bool get isExcel
bool get isPPT
bool get isApk
bool get isPdf
bool get isHtml

String get reverse

Future<void> copyToClipboard()

String capitalizeFirstLetter()
String repeat(int n, {String separator = ''})
String formatNumberWithComma({String seperator = ','})
String toYouTubeId({bool trimWhitespaces = true})
String getYouTubeThumbnail()
String removeAllWhiteSpace()
String getNumericOnly({bool aFirstWordOnly = false})
String toSlug({String delimiter = '_'})

Color toColor({Color? defaultColor})

List<String> toList()
List<String> setSearchParam()

int toInt({int defaultValue = 0})
int countWords()

double toDouble({double defaultValue = 0.0})
double calculateReadTime({int wordsPerMinute = 200})
```

## bool Extensions
```dart
bool validate({bool value = false})
```

## Color Extensions
```dart
String toHex({bool leadingHashSign = true, bool includeAlpha = false})

bool isDark()

bool isLight()

double getBrightness()

double getLuminance()
```

## BuildContext Extensions
```dart
Size size()

/// return screen width
double width()
/// return screen height
double height()

double pixelRatio()

Brightness platformBrightness()

double get statusBarHeight
double get navigationBarHeight

ThemeData get theme
TextTheme get textTheme
DefaultTextStyle get defaultTextStyle
FormState? get formState
ScaffoldState get scaffoldState
OverlayState? get overlayState

Color get primaryColor
Color get accentColor
Color get scaffoldBackgroundColor
Color get cardColor
Color get dividerColor
Color get iconColor

void requestFocus(FocusNode focus)

bool isPhone()
bool isTablet()
bool isDesktop()

```

## DateTime Extensions - Utils
```dart

/// You can use .timeAgo on a DateTime object like this
String result = DateTime.now().timeAgo;

bool get isToday
bool get isYesterday
bool get isTomorrow

/// return current time in milliseconds
int currentMillisecondsTimeStamp()

/// return current timestamp
int currentTimeStamp()

bool leapYear(int year)

/// returns how much time ago from timestamp
String formatTime(int timestamp)

/// returns number of days in given month
int daysInMonth(int monthNum, int year)
```

## Device Extensions
```dart
DeviceSize get device
    
bool get isWeb
bool get isMobile
bool get isDesktop
bool get isApple
bool get isGoogle
bool get isAndroid
bool get isIOS
bool get isMacOS
bool get isLinux
bool get isWindows
    
String get operatingSystemName
String get operatingSystemVersion
```

## Double Extensions
```dart
double validate({double value = 0.0})

bool isBetween(num first, num second)
    
Size get size
```

## Duration Extensions
```dart
/// await Duration(seconds: 1).delay();
Future<void> get delay
```

## int Extensions
```dart
/// Validate given int is not null and returns given value if null.
int validate({int value = 0})

/// Leaves given height of space ex: 16.height,
Widget get height
/// Leaves given width of space ex: 16.width,
Widget get width

/// HTTP status code
bool isSuccessful()

BorderRadius borderRadius([double? val])

/// Returns microseconds duration
/// 5.microseconds
Duration get microseconds
Duration get milliseconds
Duration get seconds
Duration get minutes
Duration get hours
Duration get days

bool isBetween(num first, num second)

Size get size

// return suffix (th,st,nd,rd) of the given month day number
String toMonthDaySuffix()

// returns month name from the given int
String toMonthName({bool isHalfName = false})

// returns WeekDay from the given int
String toWeekDay({bool isHalfName = false})
```

## List Extensions
```dart
/// Validate given List is not null and returns blank list if null.
List<T> validate()

/// Generate forEach but gives index for each element
void forEachIndexed(void action(T element, int index))

int sumBy(int Function(T) selector)

double sumByDouble(num Function(T) selector)

double? averageBy(num Function(T) selector)
```

## num Extensions
```dart
/// Validate given double is not null and returns given value if null.
num validate({num value = 0})

/// Returns price with currency
String toCurrencyAmount()
```

## ScrollController Extensions
```dart
ScrollController scrollController = ScrollController();

/// animate to top
scrollController.animToTop();
/// animate to Bottom
scrollController.animToBottom();
/// animate to specific position
scrollController.animateToPosition(20.0);
/// jump to the start of the list without animation
scrollController.jumpToTop();
/// jump to the end of the list without animation
scrollController.jumpToBottom();
```

## Widget Extensions
```dart
Widget onTap(Function? function, {BorderRadius? borderRadius, Color? splashColor,Color? hoverColor, Color? highlightColor})
Future<T?> launch<T>(BuildContext context,{bool isNewTask = false, PageRouteAnimation? pageRouteAnimation,Duration? duration})

Widget expand({flex = 1})
Widget flexible({flex = 1, FlexFit? fit})
Widget fit({BoxFit? fit, AlignmentGeometry? alignment})
Widget withTooltip({required String msg})
Widget center({double? heightFactor, double? widthFactor})
Widget visible(bool visible, {Widget? defaultWidget})

SizedBox withSize({double width = 0.0, double height = 0.0})
SizedBox withWidth(double width)
SizedBox withHeight(double height)
Padding paddingTop(double top)
Padding paddingLeft(double left)
Padding paddingRight(double right)
Padding paddingBottom(double bottom
Padding paddingAll(double padding)
Padding paddingOnly({double top = 0.0,double left = 0.0,double bottom = 0.0,double right = 0.0})
Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0})

/// Make Image Circular with these extension
ClipRRect cornerRadiusWithClipRRectOnly({int bottomLeft = 0,int bottomRight = 0,int topLeft = 0,int topRight = 0})
ClipRRect cornerRadiusWithClipRRect(double radius)

Widget opacity({required double opacity,int durationInSecond = 1,Duration? duration})
Widget rotate({required double angle,bool transformHitTests = true,Offset? origin})
Widget scale({required double scale,Offset? origin,AlignmentGeometry? alignment,bool transformHitTests = true})
Widget translate({required Offset offset,bool transformHitTests = true,Key? key})
```

## Systems Methods
```dart
/// Change status bar Color and Brightness
setStatusBarColor(Colors.blue);

setDarkStatusBar();
setLightStatusBar();

/// Show Status Bar
showStatusBar();

/// Hide Status Bar
hideStatusBar();

/// Set orientation to portrait
setOrientationPortrait();

/// Set orientation to landscape
setOrientationLandscape();

/// Get current PlatformName as a String
String platformName();

/// Enter FullScreen Mode (Hides Status Bar and Navigation Bar)
enterFullScreen();

/// Unset Full Screen to normal state (Now Status Bar and Navigation Bar Are Visible)
exitFullScreen();

/// Returns a string from Clipboard
Future<String> paste();

/// Invoke Native method and get result
var data = await invokeNativeMethod(CHANNEL_NAME, METHOD_NAME, [dynamic arguments]);
```

## Network Utils
```dart
Future<bool> isNetworkAvailable()
Future<bool> isConnectedToMobile()
Future<bool> isConnectedToWiFi()
```

## JWT Decoder
```dart
/// Pass your token here to get Map<String, dynamic>
Map<String, dynamic> JwtDecoder.decode(token);

bool JwtDecoder.isExpired(token);
DateTime JwtDecoder.getExpirationDate(token);
Duration JwtDecoder.getTokenTime(token);
Duration JwtDecoder.getRemainingTime(token);
```

## Show Dialogs
```dart

/// Show Dialog with Default Animation
showInDialog(context, builder: (context) => AnyWidget());

/// Show Dialog with Rotate Animation
showInDialog(context, builder: (context) => AnyWidget(), dialogAnimation: DialogAnimation.ROTATE);

/// Show Dialog with Scale Animation
showInDialog(context, builder: (context) => AnyWidget(), dialogAnimation: DialogAnimation.SCALE);

/// Show Dialog with Top to Bottom Animation
showInDialog(context, builder: (context) => AnyWidget(), dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM);

/// Show Dialog with Bottom to Top Animation
showInDialog(context, builder: (context) => AnyWidget(), dialogAnimation: DialogAnimation.SLIDE_BOTTOM_TOP);

/// Show Dialog with Left to Right Animation
showInDialog(context, builder: (context) => AnyWidget(), dialogAnimation: DialogAnimation.SLIDE_LEFT_RIGHT);

/// Show Dialog with Right to Left Animation
showInDialog(context, builder: (context) => AnyWidget(), dialogAnimation: DialogAnimation.SLIDE_RIGHT_LEFT);

/// Show Confirmation Dialog
/// Second parameter is Title
showConfirmDialog(
  context,
  'Do you want to logout from the app?',
  onAccept: (context) {
    //
  },
);
```

## Custom Dialogs
```dart
AppButton(
  text: "Add",
  onTap: () {
    showConfirmDialogCustom(
      context,
      title: "Do you want to add this item?",
      dialogType: DialogType.ADD,
      onAccept: () {
        snackBar(context, title: 'Added');
      },
    );
  },
),
```
![Add Confirmation Dialog](https://github.com/bhoominn/nb_utils/blob/main/screenshots/add_confirmation_dialog.gif)

```dart
AppButton(
  text: "Delete",
  onTap: () {
    showConfirmDialogCustom(
      context,
      title: "Delete 89 files permanent?",
      dialogType: DialogType.DELETE,
      onAccept: () {
        snackBar(context, title: 'Deleted');
      },
    );
  },
),
```
![Delete Confirmation Dialog](https://github.com/bhoominn/nb_utils/blob/main/screenshots/delete_confirmation_dialog.gif)

```dart
AppButton(
  text: "Update",
  onTap: () {
    showConfirmDialogCustom(
      context,
      title: "Do you want to update this item?",
      dialogType: DialogType.UPDATE,
      onAccept: () {
        snackBar(context, title: 'Updated');
      },
    );
  },
),
```
![Update Confirmation Dialog](https://github.com/bhoominn/nb_utils/blob/main/screenshots/update_confirmation_dialog.gif)

```dart
AppButton(
  text: "Confirmation with Custom Image",
  onTap: () async {
    showConfirmDialogCustom(
      context,
      title: "Do you want to logout from the app?",
      dialogType: DialogType.CONFIRMATION,
      centerImage: 'URL',
      onAccept: () {
        //
      },
      onCancel: () {
        //
      },
      height: 300,
      width: 400,
    );
  },
),
```
![Custom Confirmation Dialog](https://github.com/bhoominn/nb_utils/blob/main/screenshots/custom_confirmation_dialog.gif)

```dart
AppButton(
  text: "Confirmation",
  onTap: () {
    showConfirmDialogCustom(
      context,
      onAccept: () {
        snackBar(
          context,
          title: 'Confirmed',
          snackBarAction: SnackBarAction(label: 'label', onPressed: () {}),
        );
      },
    );
  },
),
```
![Default Confirmation Dialog](https://github.com/bhoominn/nb_utils/blob/main/screenshots/default_confirmation_dialog.gif)

# Image Previews

## GoogleLogoWidget 
![GoogleLogoWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/google_logo_widget.gif)

## Loader Widget
![Loader](https://github.com/bhoominn/nb_utils/blob/main/screenshots/loader_widget.gif)

## SettingSection
![SettingSection](https://github.com/bhoominn/nb_utils/blob/main/screenshots/setting_section_widget.jpg)

## SettingItemWidget
![SettingItemWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/setting_item_widget.jpg)

## AppButton
![AppButton](https://github.com/bhoominn/nb_utils/blob/main/screenshots/app_button.gif)

## UL Widget
![UL](https://github.com/bhoominn/nb_utils/blob/main/screenshots/ul_widget.jpg)

## AppTextField
![AppTextField](https://github.com/bhoominn/nb_utils/blob/main/screenshots/app_text_field_widget.jpg)

## HorizontalList Widget
![HorizontalList](https://github.com/bhoominn/nb_utils/blob/main/screenshots/horizontal_widget.gif)

## RatingBarWidget
![RatingBarWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/rating_bar_widget.gif)

## Responsive Widget
![Responsive](https://github.com/bhoominn/nb_utils/blob/main/screenshots/responsive_widget.gif)

## DotIndicator Widget
![DotIndicator](https://github.com/bhoominn/nb_utils/blob/main/screenshots/dot_indicator.gif)

## DottedBorderWidget
![DottedBorderWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/dotted_border_widget.jpg)

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/bhoominn/nb_utils/issues

## ⭐ If you like the package, a star to the repo will mean a lot.

## You can also contribute by adding new widgets or helpful methods.

## If you want to give suggestion, please contact me via email - bhoominn@gmail.com

## Thank you ❤