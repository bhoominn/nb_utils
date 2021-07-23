import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: [
    LanguageDataModel(name: 'English', languageCode: 'en'),
    LanguageDataModel(name: 'Hindi', languageCode: 'hi'),
  ]);

  defaultToastBackgroundColor = Colors.black;
  defaultToastTextColor = Colors.white;
  defaultToastGravityGlobal = ToastGravity.CENTER;

  selectedLanguageDataModel = getSelectedLanguageModel();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await NBUtils.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NB Utils Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Colors.blue),
        scaffoldBackgroundColor: scaffoldLightColor,
      ),
      darkTheme: ThemeData(
        primarySwatch: createMaterialColor(Colors.blue),
      ),
      themeMode:
          getIntAsync(THEME_MODE_INDEX) == 2 ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> formKey = GlobalKey();
  double rating = 2.2;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Home', showBack: Navigator.canPop(context)),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                ThemeWidget(
                  onThemeChanged: (data) {
                    log(data);
                  },
                ),
                LanguageListWidget(
                  widgetType: WidgetType.DROPDOWN,
                  onLanguageChange: (data) {
                    log(data.name);
                  },
                ),
                16.height,

                DottedBorderWidget(
                  child: Container(
                    height: 100,
                    width: 100,
                  ),
                ),
                16.height,

                /// Gradient Border Widget
                GradientBorder(
                  gradient: LinearGradient(
                      colors: [Colors.orange, Colors.yellow, Colors.pink]),
                  strokeWidth: 4.0,
                  child: Container(
                    child: Image.network(
                        "https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                  ),
                ).paddingAll(18),

                ///
                Text('Rating Bar Widget Example', style: primaryTextStyle()),
                8.height,
                RatingBarWidget(
                  rating: rating,
                  size: 40,
                  allowHalfRating: true,
                  onRatingChanged: (e) {
                    rating = e;
                    log(rating);
                  },
                ),
                16.height,

                /// Hover Widget Example
                Text('Hover Widget Example', style: primaryTextStyle()),
                8.height,
                HoverWidget(
                  builder: (_, isHovering) {
                    return AnimatedContainer(
                      height: 100,
                      width: 100,
                      decoration: boxDecorationDefault(
                        color: isHovering ? Colors.blue : Colors.white,
                        borderRadius: radius(isHovering ? 50 : null),
                      ),
                      duration: 400.milliseconds,
                    );
                  },
                ),
                Column(
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        AppButton(
                          text: "Confirmation",
                          onTap: () {
                            showConfirmDialog(context, "hehhe",
                                dialogAnimation: DialogAnimation.ROTATE);
                          },
                        ),
                        AppButton(
                          text: "Confirmation with Custom Image",
                          onTap: () async {
                            showConfirmDialogCustom(
                              context,
                              dialogAnimation: DialogAnimation.SLIDE_RIGHT_LEFT,
                              title: "Do you want to logout from the app?",
                              dialogType: DialogType.CONFIRMATION,
                              centerImage:
                                  'https://images.unsplash.com/photo-1579154392429-0e6b4e850ad2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=397&q=80',
                              onAccept: (_) {
                                //
                              },
                              onCancel: (_) {
                                //
                              },
                              height: 300,
                              width: 400,
                            );
                          },
                        ),
                        AppButton(
                          text: "Update",
                          onTap: () {
                            showConfirmDialogCustom(
                              context,
                              dialogAnimation: DialogAnimation.SLIDE_BOTTOM_TOP,
                              title: "Do you want to update this item?",
                              dialogType: DialogType.UPDATE,
                              onAccept: (_) {
                                snackBar(context, title: 'Updated');
                              },
                            );
                          },
                        ),
                        AppButton(
                          text: "Delete",
                          onTap: () {
                            showConfirmDialogCustom(
                              context,
                              dialogAnimation: DialogAnimation.SLIDE_LEFT_RIGHT,
                              title: "Delete 89 files permanent?",
                              dialogType: DialogType.DELETE,
                              onAccept: (_) {
                                snackBar(context, title: 'Deleted');
                              },
                            );
                          },
                        ),
                        AppButton(
                          text: "Add",
                          onTap: () {
                            showConfirmDialogCustom(
                              context,
                              title: "Do you want to add this item?",
                              dialogType: DialogType.ADD,
                              onAccept: (_) {
                                snackBar(context, title: 'Added');
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    16.height,
                    UL(
                      symbolType: SymbolType.Numbered,
                      children: [
                        Text('Hi', style: primaryTextStyle()),
                        Text('Hello', style: primaryTextStyle()),
                        Text('How are you?', style: primaryTextStyle()),
                      ],
                    ),
                    16.height,
                    UL(
                      children: [
                        Text('Hi', style: primaryTextStyle()),
                        Text('Hello', style: primaryTextStyle()),
                        Text('How are you?', style: primaryTextStyle()),
                      ],
                    ),
                    16.height,

                    /// Default AppTextField
                    AppTextField(
                      textFieldType: TextFieldType.OTHER,
                      decoration: defaultInputDecoration(),
                    ),
                    8.height,

                    /// Email TextField
                    AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      decoration: defaultInputDecoration(label: 'Email'),
                    ),
                    8.height,

                    /// Address TextField
                    AppTextField(
                      textFieldType: TextFieldType.ADDRESS,
                      decoration: defaultInputDecoration(label: 'Address'),
                      minLines: 4,
                    ),
                    8.height,

                    /// Password TextField
                    AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: defaultInputDecoration(label: 'Password'),
                    ),
                  ],
                ).paddingAll(16),
                GoogleLogoWidget(size: 30),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      text: 'Save',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        }
                      },
                    ),
                    8.width,
                    AppButton(
                      text: 'Toast',
                      onTap: () async {
                        toasty(context, 'Toast',
                            borderRadius: BorderRadius.circular(1),
                            textColor: Colors.pinkAccent,
                            gravity: ToastGravity.CENTER);
                      },
                    ),
                  ],
                ),
                16.height,
                SettingSection(
                  title: Text('Account Management',
                      style: boldTextStyle(size: 24)),
                  subTitle: Text('Control your account',
                      style: primaryTextStyle(size: 16)),
                  items: [
                    SettingItemWidget(
                      title: 'Hibernate account',
                      subTitle: 'Temporary deactivate your account',
                      decoration: BoxDecoration(borderRadius: radius()),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded,
                          color: context.dividerColor),
                      onTap: () {
                        //
                      },
                    ),
                    SettingItemWidget(
                      title: 'Close account',
                      subTitle:
                          'Learn about your options, and close your account if you wish',
                      decoration: BoxDecoration(borderRadius: radius()),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded,
                          color: context.dividerColor),
                      onTap: () {
                        HomePage().launch(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
