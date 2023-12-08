import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'animated_listview_example.dart';

const APP_NAME = 'NB Utils Example';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: [
    LanguageDataModel(name: 'English', languageCode: 'en'),
    LanguageDataModel(name: 'Hindi', languageCode: 'hi'),
  ]);

  defaultToastBackgroundColor = Colors.black;
  defaultToastTextColor = Colors.white;
  defaultToastGravityGlobal = ToastGravity.CENTER;
  defaultRadius = 16;
  defaultAppButtonRadius = 16;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeData>(
      future: getMaterialYouTheme(),
      builder: (_, snap) {
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: snap.data ??
              ThemeData.light(
                useMaterial3: true,
              ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: getIntAsync(THEME_MODE_INDEX) == 2
              ? ThemeMode.dark
              : ThemeMode.light,
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController textCont = TextEditingController();

  double rating = 2.2;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Widget dialogWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('This is the example of showInDialog method',
              style: primaryTextStyle()),
          4.height,
          Text('Secondary text here', style: secondaryTextStyle()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return DoublePressBackWidget(
      child: Scaffold(
        appBar: AppBar(backgroundColor: transparentColor),
        drawerEdgeDragWidth: context.width() * 0.2,
        drawerEnableOpenDragGesture: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  16.height,
                  OTPTextField(
                    boxDecoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: radius(4),
                    ),
                    onChanged: (text) {
                      log(text);
                    },
                    onCompleted: (s) {
                      toast('onCompleted $s');
                    },
                  ),
                  16.height,
                  TextButton(
                    onPressed: () {
                      AnimatedListViewExample().launch(context);
                    },
                    child: Text('Pagination Example'),
                  ),

                  16.height,
                  RoundedCheckBox(
                    size: 24,
                    text: 'Remember me',
                    onTap: (val) {
                      //
                    },
                  ),

                  /*16.height,
                  SizeListener(
                    child: PlaceHolderWidget(
                      height: 50.dynamicHeight,
                      width: 100.dynamicWidth,
                    ),
                    onSizeChange: (size) {
                      log(size.width.toString());
                    },
                  ),*/

                  16.height,
                  SnapHelperWidget(
                    future: getMaterialYouColors(),
                    onSuccess: (data) {
                      //var data1 = (data as Map).values.map((e) => e.toString().toColor()).toList();

                      return Wrap(
                        children: (data as Map).entries.map((e) {
                          return Container(
                            height: 50,
                            color: e.value.toString().toColor(),
                            child: Text(e.key),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  16.height,
                  LanguageListWidget(
                    widgetType: WidgetType.DROPDOWN,
                    onLanguageChange: (data) {
                      log(data.name);
                    },
                  ),

                  16.height,
                  DottedBorderWidget(child: Container(height: 100, width: 100)),

                  16.height,

                  /// Gradient Border Widget
                  GradientBorder(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.yellow,
                        Colors.pink,
                      ],
                    ),
                    strokeWidth: 4.0,
                    child: Image.network(
                      "https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      width: 100,
                    ).cornerRadiusWithClipRRect(8),
                  ),

                  16.height,
                  Text('Rating Bar Widget Example', style: primaryTextStyle()),
                  RatingBarWidget(
                    rating: rating,
                    size: 40,
                    activeColor: context.primaryColor,
                    //allowHalfRating: true,
                    onRatingChanged: (e) {
                      rating = e;
                    },
                  ),

                  16.height,

                  /// Hover Widget Example
                  Text('Hover Widget Example', style: primaryTextStyle()),
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

                  16.height,
                  Column(
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          AppButton(
                            text: "Theme",
                            onTap: () async {
                              showInDialog(context, builder: (_) {
                                return SizedBox(
                                  height: 400,
                                  width: 500,
                                  child: ThemeWidget(
                                    onThemeChanged: (data) {
                                      setState(() {});
                                      log(data);
                                    },
                                  ),
                                );
                              },
                                  title: Text('Theme'),
                                  contentPadding: EdgeInsets.zero);
                            },
                          ),
                          AppButton(
                            text: "Confirmation",
                            onTap: () async {
                              showConfirmDialogCustom(
                                context,
                                dialogAnimation: DialogAnimation.DEFAULT,
                                onAccept: (_) {
                                  snackBar(context, title: 'Confirmed');
                                },
                              );
                            },
                          ),
                          AppButton(
                            text: "Confirmation with Custom Image",
                            onTap: () async {
                              showConfirmDialogCustom(
                                context,
                                dialogAnimation:
                                    DialogAnimation.SLIDE_RIGHT_LEFT,
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
                                dialogAnimation:
                                    DialogAnimation.SLIDE_BOTTOM_TOP,
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
                                dialogAnimation:
                                    DialogAnimation.SLIDE_LEFT_RIGHT,
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
                                dialogAnimation:
                                    DialogAnimation.SLIDE_TOP_BOTTOM,
                                onAccept: (_) {
                                  snackBar(context, title: 'Added');
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      16.height,

                      /// Hover Widget Example
                      Text('Dialog Animation Example',
                          style: primaryTextStyle()),
                      8.height,
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AppButton(
                            text: 'Default',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget());
                            },
                          ),
                          AppButton(
                            text: 'Rotate',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget(),
                                  dialogAnimation: DialogAnimation.ROTATE);
                            },
                          ),
                          AppButton(
                            text: 'Scale',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget(),
                                  dialogAnimation: DialogAnimation.SCALE);
                            },
                          ),
                          AppButton(
                            text: 'Top to Bottom',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget(),
                                  dialogAnimation:
                                      DialogAnimation.SLIDE_TOP_BOTTOM);
                            },
                          ),
                          AppButton(
                            text: 'Bottom to Top',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget(),
                                  dialogAnimation:
                                      DialogAnimation.SLIDE_BOTTOM_TOP);
                            },
                          ),
                          AppButton(
                            text: 'Left to Right',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget(),
                                  dialogAnimation:
                                      DialogAnimation.SLIDE_LEFT_RIGHT);
                            },
                          ),
                          AppButton(
                            text: 'Right to Left',
                            onTap: () async {
                              showInDialog(context,
                                  builder: (_) => dialogWidget(),
                                  dialogAnimation:
                                      DialogAnimation.SLIDE_RIGHT_LEFT);
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

                      /// Default AppTextField With ChatGPT
                      AppTextField(
                        controller: textCont,
                        textFieldType: TextFieldType.OTHER,
                        enableChatGPT: true,
                        testWithoutKeyChatGPT: true,
                        decoration: defaultInputDecoration(),
                      ),
                      8.height,

                      /// Email TextField
                      AppTextField(
                        textFieldType: TextFieldType.EMAIL,
                        decoration: defaultInputDecoration(label: 'Email'),
                        title: 'Email',
                      ),
                      8.height,

                      /// Address TextField
                      AppTextField(
                        textFieldType: TextFieldType.MULTILINE,
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

                  16.height,
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
                          push(HomePage());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
