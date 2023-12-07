import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'chatgpt.dart';
import 'chatgpt_strings.dart';

class ChatGPTSheetBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final List<String> recentList;
  final bool showDebugLogs;
  final bool shortReply;
  final bool testWithoutKey;
  final Widget? loading;
  final InputDecoration? promptFieldInputDecoration;
  ChatGPTSheetBottomSheet({
    super.key,
    required this.recentList,
    this.showDebugLogs = false,
    this.shortReply = false,
    this.testWithoutKey = false,
    this.promptFieldInputDecoration,
    required this.scrollController,
    this.loading,
  });

  @override
  State<ChatGPTSheetBottomSheet> createState() => _ChatGPTSheetBottomSheetState();
}

class _ChatGPTSheetBottomSheetState extends State<ChatGPTSheetBottomSheet> {
  TextEditingController promptCont = TextEditingController();
  TextEditingController answerCont = TextEditingController();

  bool displayGeneratedText = false;
  bool isTextAnimationCompleted = false;
  bool isLoading = false;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: context.height() * 0.04),
            decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius), backgroundColor: context.scaffoldBackgroundColor),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SingleChildScrollView(
                  controller: widget.scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(GPTModuleStrings.generateUsingAI, style: boldTextStyle(color: context.primaryColor, size: 16)).expand(),
                          CloseButton(color: context.primaryColor),
                        ],
                      ),
                      AppTextField(
                        textFieldType: TextFieldType.MULTILINE,
                        controller: promptCont,
                        decoration: widget.promptFieldInputDecoration ?? defaultInputDecoration(hint: GPTModuleStrings.writeTextHere),
                      ),
                      32.height,
                      Column(
                        children: [
                          AppButton(
                            text: answerCont.text.isNotEmpty ? GPTModuleStrings.reGenerate : GPTModuleStrings.generate,
                            color: context.primaryColor,
                            textStyle: boldTextStyle(color: white),
                            width: context.width(),
                            onTap: () {
                              handleGenerateClick(context);
                            },
                          ),
                          16.height,
                          if (isTextAnimationCompleted)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(context.primaryColor.withOpacity(0.1)), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 2))),
                                  onPressed: () {
                                    finish(context, answerCont.text);
                                  },
                                  child: Text(
                                    GPTModuleStrings.useThis,
                                    style: boldTextStyle(color: context.primaryColor),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(context.primaryColor.withOpacity(0.1)), padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 2))),
                                  onPressed: () {
                                    finish(context, promptCont.text);
                                  },
                                  child: Text(
                                    GPTModuleStrings.useMyText,
                                    style: boldTextStyle(color: context.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          16.height,
                          isLoading
                              ? autoTypingView(context, loading: widget.loading)
                              : Container(
                                  padding: EdgeInsets.all(8),
                                  width: context.width(),
                                  decoration: boxDecorationWithRoundedCorners(borderRadius: radius(defaultRadius), backgroundColor: displayGeneratedText ? context.primaryColor.withOpacity(0.1) : transparentColor),
                                  child: DefaultTextStyle(
                                    style: primaryTextStyle(),
                                    child: AnimatedTextKit(
                                      repeatForever: false,
                                      totalRepeatCount: 1,
                                      isRepeatingAnimation: false,
                                      onFinished: () {
                                        if (!isTextAnimationCompleted) {
                                          widget.recentList.insert(0, answerCont.text);
                                        }
                                        isTextAnimationCompleted = true;
                                        setState(() {});
                                      },
                                      animatedTexts: [
                                        TypewriterAnimatedText(answerCont.text, speed: Duration(milliseconds: isTextAnimationCompleted ? 0 : 30)),
                                      ],
                                    ),
                                  ).visible(displayGeneratedText),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              16.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(GPTModuleStrings.recents, style: boldTextStyle(color: context.primaryColor, size: 16)),
                                  IconButton(
                                    icon: Icon(Icons.clear_all_rounded, color: context.primaryColor),
                                    onPressed: () async {
                                      showConfirmDialogCustom(
                                        context,
                                        onAccept: (_) async {
                                          widget.recentList.clear();
                                          setState(() {});
                                        },
                                        primaryColor: context.primaryColor,
                                        negativeText: GPTModuleStrings.no,
                                        positiveText: GPTModuleStrings.yes,
                                        title: GPTModuleStrings.doYouWantClearRecents,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                height: context.height() * 0.42,
                                child: AnimatedListView(
                                  shrinkWrap: true,
                                  itemCount: widget.recentList.take(6).length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  listAnimationType: ListAnimationType.FadeIn,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        finish(context, widget.recentList[index]);
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 12),
                                        padding: EdgeInsets.all(8),
                                        decoration: boxDecorationWithRoundedCorners(borderRadius: radius(defaultRadius), backgroundColor: context.primaryColor.withOpacity(0.05)),
                                        child: ReadMoreText(
                                          widget.recentList[index],
                                          trimLines: 3,
                                          textAlign: TextAlign.left,
                                          style: secondaryTextStyle(size: 14),
                                          colorClickableText: context.primaryColor,
                                          trimMode: TrimMode.Line,
                                          locale: Localizations.localeOf(context),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ).visible(widget.recentList.isNotEmpty)
                        ],
                      )
                    ],
                  ),
                ).expand(),
              ],
            ),
          ).expand(),
        ],
      ),
    );
  }

  void handleGenerateClick(BuildContext context) async {
    if (isLoading || (answerCont.text.isNotEmpty && !isTextAnimationCompleted)) {
      toast(GPTModuleStrings.pleaseWaitGeneratingContent);
      return;
    }
    if (promptCont.text.isEmpty) {
      toast(GPTModuleStrings.pleaseEnterTextToGenerate);
      return;
    }
    hideKeyboard(context);
    isLoading = true;
    displayGeneratedText = false;
    isTextAnimationCompleted = false;
    setState(() {});

    generateWithChatGpt(
      "${promptCont.text} \n Make this proper ",
      shortReply: widget.shortReply,
      showDebugLogs: widget.showDebugLogs,
      testWithoutKey: widget.testWithoutKey,
    ).then((value) async {
      answerCont.text = value.trim();
      await 350.milliseconds.delay;
      displayGeneratedText = true;
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() {
      isLoading = false;
    });
  }
}
