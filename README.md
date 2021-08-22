[![Pub Package](https://img.shields.io/pub/v/nb_utils.svg)](https://pub.dartlang.org/packages/nb_utils)
<a href="https://opensource.org/licenses/MIT" target="_blank">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg"/>
</a>
<a href="https://saythanks.io/to/bhoominn%40gmail.com" target="_blank">
  <img src="https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg"/>
</a>
<a href="https://opensource.org/licenses/Apache-2.0" target="_blank">
  <img src="https://badges.frapsoft.com/os/v1/open-source.svg?v=102"/>
</a>
<a href="https://github.com/bhoominn/nb_utils/issues" target="_blank">
    <img alt="GitHub: bhoominn" src="https://img.shields.io/github/issues-raw/bhoominn/nb_utils?style=flat" />
</a>
<img src="https://img.shields.io/tokei/lines/github/bhoominn/nb_utils" />
<img src="https://img.shields.io/github/last-commit/bhoominn/nb_utils" />
<a href="https://discord.com/channels/854023838136533063/854023838576672839" target="_blank">
    <img src="https://img.shields.io/discord/854023838136533063" />
</a>
<a href="https://pub.dev/packages/nb_utils/score"><img src="https://badges.bar/nb_utils/likes"></a>
<a href="https://pub.dev/packages/nb_utils/pub%20points"><img src="https://badges.bar/nb_utils/pub%20points"></a>
<a href="https://github.com/bhoominn">
    <img alt="GitHub: bhoominn" src="https://img.shields.io/github/followers/bhoominn?label=Follow&style=social" target="_blank" />
</a>
<a href="https://github.com/bhoominn/nb_utils">
    <img src="https://img.shields.io/github/stars/bhoominn/nb_utils?style=social" />
</a>
<a href="https://twitter.com/bhoominnaik" target="_blank">
  <img src="https://img.shields.io/twitter/follow/bhoominnaik?color=1DA1F2&label=Followers&logo=twitter"/>
</a>

<a href="https://www.buymeacoffee.com/bhoominn"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=bhoominn&button_colour=5F7FFF&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00"></a>

## Show some love and like to support the project

## Documentation

[API Docs](https://pub.dev/documentation/nb_utils/latest/) are available.

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

## Migrating from 4.3.1 to 4.4.0+
BuildContext parameter is added to onAccept and onCancel in showConfirmDialogCustom method.

## Featured on Google's Dev Library
<a href="https://devlibrary.withgoogle.com/products/flutter/repos/bhoominn-nb_utils" target="_blank">Checkout here</a>
<a href="https://devlibrary.withgoogle.com/authors" target="_blank">Dev Library Contributors</a>

# Examples

## Ready to Use widgets with Optional Parameters

```dart
/// Add a Google Logo
/// Add size parameter for custom size - Default is 24
GoogleLogoWidget(),
```
![GoogleLogoWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/google_logo_widget.gif)

```dart
/// You can use your preferred State Management technique
Loader().visible(mIsLoading),
```
![Loader](https://github.com/bhoominn/nb_utils/blob/main/screenshots/loader_widget.gif)

```dart
/// AppBar widget
appBarWidget(
  "Title",
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
![SettingSection](https://github.com/bhoominn/nb_utils/blob/main/screenshots/setting_section_widget.jpg)

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
![SettingItemWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/setting_item_widget.jpg)

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
![AppButton](https://github.com/bhoominn/nb_utils/blob/main/screenshots/app_button.gif)

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
![UL](https://github.com/bhoominn/nb_utils/blob/main/screenshots/ul_widget.jpg)

```dart
/// Use AppTextField on your app to try more properties
AppTextField(
    controller: TextEditingController(), // Optional
    textFieldType: TextFieldType.EMAIL,
    decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
),
AppTextField(
    controller: TextEditingController(), // Optional
    textFieldType: TextFieldType.ADDRESS,
    decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
),
AppTextField(
    controller: TextEditingController(), // Optional
    textFieldType: TextFieldType.PASSWORD,
    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
),
```
![AppTextField](https://github.com/bhoominn/nb_utils/blob/main/screenshots/app_text_field_widget.jpg)

```dart
HoverWidget(
    builder: (context, bool isHovering) {
        return Container(
            /// isHovering will be true when you hover on it.

            color: isHovering ? Colors.yellow : Colors.blue,
        )
    }
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
![HorizontalList](https://github.com/bhoominn/nb_utils/blob/main/screenshots/horizontal_widget.gif)
```dart
RatingBarWidget(
    rating: initialRating,
    onRatingChanged: (aRating) {
        rating = aRating;
    },
),
```
![RatingBarWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/rating_bar_widget.gif)

```dart
/// Make your Flutter App Responsive in any device out there with Responsive widget
Responsive(
    mobile: MobileWidget(),
    tablet: TabletWidget(), // Optional
    web: WebWidget(), // Optional
),
```
![Responsive](https://github.com/bhoominn/nb_utils/blob/main/screenshots/responsive_widget.gif)

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
![DotIndicator](https://github.com/bhoominn/nb_utils/blob/main/screenshots/dot_indicator.gif)

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
![DottedBorderWidget](https://github.com/bhoominn/nb_utils/blob/main/screenshots/dotted_border_widget.jpg)

```dart
Marquee(
    direction: Axis.horizontal,
    animationDuration: Duration(milliseconds: 100),
    pauseDuration: Duration(milliseconds: 100),
    child: Text("Please enter a long text to see the effect of the marquee widget"),
),
```

## Show Dialogs
```dart

/// Show Dialog with Default Animation
showInDialog(context, builder: (context) => dialogWidget());

/// Show Dialog with Rotate Animation
showInDialog(context, builder: (context) => dialogWidget(), dialogAnimation: DialogAnimation.ROTATE);

/// Show Dialog with Scale Animation
showInDialog(context, builder: (context) => dialogWidget(), dialogAnimation: DialogAnimation.SCALE);

/// Show Dialog with Top to Bottom Animation
showInDialog(context, builder: (context) => dialogWidget(), dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM);

/// Show Dialog with Bottom to Top Animation
showInDialog(context, builder: (context) => dialogWidget(), dialogAnimation: DialogAnimation.SLIDE_BOTTOM_TOP);

/// Show Dialog with Left to Right Animation
showInDialog(context, builder: (context) => dialogWidget(), dialogAnimation: DialogAnimation.SLIDE_LEFT_RIGHT);

/// Show Dialog with Right to Left Animation
showInDialog(context, builder: (context) => dialogWidget(), dialogAnimation: DialogAnimation.SLIDE_RIGHT_LEFT);


/// Show Confirmation Dialog
/// Second parameter is title
showConfirmDialog(
  context,
  'Do you want to logout from the app?',
  onAccept: (context) {
    //
  },
);
```

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

```

```dart
// Basic
snackBar(context, title: 'Sample toast'),
```

```dart
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

## Shared Preferences
```dart

/// Shared Preferences
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

## Widgets Extensions, Methods
```dart
/// With custom height and width
AnyWidget().withSize(height: 25, width: 50);

/// With custom width
AnyWidget().withWidth(25);

/// With custom height
AnyWidget().withHeight(100);

/// return padding top
AnyWidget().paddingTop(2);

/// return padding left
AnyWidget().paddingLeft(4);

/// return padding right
AnyWidget().paddingRight(8);

/// return padding bottom
AnyWidget().paddingBottom(16);

/// return padding all
AnyWidget().paddingAll(8);

/// return custom padding from each side
AnyWidget().paddingOnly();

/// return padding symmetric
AnyWidget().paddingSymmetric();

/// set visibility
/// true/false
AnyWidget().visible(true);

/// add custom corner radius each side
AnyWidget().cornerRadiusWithClipRRectOnly(topLeft: 10, bottomRight: 12);

/// add corner radius
AnyWidget().cornerRadiusWithClipRRect(20);

/// set widget visibility
/// true/false
AnyWidget().withVisibility(true);

/// add animated opacity to parent widget
AnyWidget().opacity(opacity: 0.2);

/// add rotation to parent widget
AnyWidget().rotate(angle: 1.2);

/// add scaling to parent widget
AnyWidget().scale(scale: 2.0);

/// set parent widget in center
AnyWidget().center();

/// add tap to parent widget
AnyWidget().onTap(() {
  //
});

/// Wrap with ShaderMask widget
AnyWidget().withShaderMask([Colors.black, Colors.red]);

/// Wrap with ShaderMask widget Gradient
AnyWidget().withShaderMaskGradient(LinearGradient(colors: [Colors.black, Colors.red]));

/// add Expanded to parent widget
AnyWidget().expand();

/// add Flexible to parent widget
AnyWidget().flexible();

/// add FittedBox to parent widget
AnyWidget().fit();

/// Validate given widget is not null and returns given value if null.
AnyWidget().validate();

/// Validate given widget is not null and returns given value if null.
AnyWidget().withTooltip(msg: "Hello");


```

## Time formatter formatTime Extensions, Methods
```dart
/// Returns how much time ago from timestamp
/// The number of milliseconds that have passed since the timestamp

/// You can use .timeAgo on a DateTime object like this
String result = DateTime.now().timeAgo;


int difference = DateTime.now().millisecondsSinceEpoch;

/// Converts the time difference to a number of seconds.
countSeconds(difference);

/// Converts the time difference to a number of minutes.
countMinutes(difference);

/// Converts the time difference to a number of hours.
countHours(difference);

/// Converts the time difference to a number of days.
countDays(difference);

/// Converts the time difference to a number of weeks.
countWeeks(difference);

/// Converts the time difference to a number of months.
countMonths(difference);

/// Converts the time difference to a number of years.
countYears(difference);
```

## Strings Extensions, Methods
```dart
/// Returns True/False

String example = "";

/// Check URL validation
example.validateURL();

/// Check email validation
example.validateEmail();

/// Check phone validation
example.validatePhone();

/// Return true if given String is Digit
example.isDigit();

/// Check weather String is alpha or not
example.isAlpha();

/// Check weather String is Json or not
example.isJson();

/// Copy String to Clipboard
example.copyToClipboard();

/// for ex. add comma in price
example.formatNumberWithComma();

/// Get Color from HEX String
example.toColor();

/// It reverses the String
example.reverse;

/// It return list of single character from String
example.toList();

/// Returns true if given String is null or isEmpty
example.isEmptyOrNull;

/// Check null string, return given value if null
example.validate();

/// Capitalize First letter of a given String
example.capitalizeFirstLetter();

/// Returns if its type image
example.isImage;

/// Returns if its type Audio
example.isAudio;

/// Returns if its type Video
example.isVideo;

/// Returns if its type Txt
example.isTxt;

/// Returns if its type Doc
example.isDoc;

/// Returns if its type Excel
example.isExcel;

/// Returns if its type PPT
example.isPPT;

/// Returns if its type Apk
example.isApk;

/// Returns if its type Pdf
example.isPdf;

/// Returns if its type Html
example.isHtml;

/// Pass the Pattern

/// Splits from a [pattern] and returns remaining String after that
example.splitAfter(Patterns.apk);

/// Splits from a [pattern] and returns String before that
example.splitBefore(Patterns.audio);

/// It matches the String and returns between [startPattern] and [endPattern]
example.splitBetween("d", "g");

/// Return int value of given string
example.toInt();

/// Get YouTube Video ID
example.toYouTubeId();

/// Returns YouTube thumbnail for given video id
example.getYouTubeThumbnail();

/// Removes white space from given String
example.removeAllWhiteSpace();

/// Returns only numbers from a string
example.getNumericOnly(example);

/// Return average read time duration of given String in seconds
example.calculateReadTime();

/// Return number of words in a given String
example.countWords();

/// Generate slug of a given String
example.toSlug();

/// returns searchable array for Firebase Database
example.setSearchParam();
```

## Scroll Controller Extensions
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

## TextStyles/ Decorations/ FocusNodes/ Context Methods
```dart
 
/// Apply Bold TextStyle
Text(item.title.validate(), style: boldTextStyle())
    
/// Apply Primary TextStyle
Text(item.title.validate(), style: primaryTextStyle())
    
/// Apply Secondary TextStyle
Text(item.title.validate(), style: secondaryTextStyle())


/// Apply default BoxDecoration with default shadow and border radius
Container(
    decoration: boxDecorationDefault(), // You can modify based on your preference
),

/// FocusNode
requestFocus(NODE_VARIABLE);
nextFocus(NODE_VARIABLE);

///  Handle error and loading widget when using FutureBuilder or StreamBuilder
/// "snap" is the snapShot value we get from FutureBuilder or StreamBuilder
return snapWidgetHelper(snap);

/// See the example below. You can user FutureBuilder or StreamBuilder.

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
)

/// return screen width
context.width();

/// return screen height
context.height();
    
/// Theme color or value from context
context.primaryColor;
context.theme.text.subtitle.color;
```

## DateTime Extensions, Methods
```dart
/// return current time in milliseconds
int currentMillisecondTimeStamp = currentMillisecondsTimeStamp();

/// return current timestamp
int currentTimeStamps = currentTimeStamp();

/// return true if given year is an leap year
/// leapYear(year)
bool isLeapYear = leapYear(2000);

/// returns number of days in given month
/// daysInMonth(monthNum, year)
int dayInMonthTotal = daysInMonth(2, 2000);

/// Returns Time Ago
/// only on datetime object
/// Just Now, 2 minutes ago, 1 hour ago, 1 day ago

String timeAgo = DateTime.now().timeAgo;
```

## Systems Methods
```dart
/// Change status bar Color and Brightness
setStatusBarColor(Colors.blue);
    
/// Show Status Bar
showStatusBar();

/// Hide Status Bar
hideStatusBar();

/// Set orientation to portrait
setOrientationPortrait();

/// Set orientation to landscape
setOrientationLandscape();

/// Get current PlatformName as a String
platformName();

/// Invoke Native method and get result
var data = await invokeNativeMethod(CHANNEL_NAME, METHOD_NAME, [dynamic arguments]);
```

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

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/bhoominn/nb_utils/issues

## If you want to give suggestion, please contact me via email - bhoominn@gmail.com

## Thank you :)