import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

/// OTPTextField widget helps you to enter your OTP
class OTPTextField extends StatefulWidget {
  final int pinLength;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  final bool showUnderline;
  final InputDecoration? decoration;
  final BoxDecoration? boxDecoration;

  final double fieldWidth;
  final TextStyle? textStyle;

  final Color? cursorColor;

  OTPTextField({
    this.pinLength = 4,
    this.fieldWidth = 40,
    this.onChanged,
    this.onCompleted,
    this.showUnderline = false,
    this.decoration,
    this.boxDecoration,
    this.textStyle,
    this.cursorColor,
    Key? key,
  }) : super(key: key);

  @override
  OTPTextFieldState createState() => OTPTextFieldState();
}

class OTPTextFieldState extends State<OTPTextField> {
  List<OTPLengthModel> list = [];
  FocusNode focusNode = FocusNode();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    list.addAll(List.generate(widget.pinLength, (index) {
      return OTPLengthModel(
        textEditingController: TextEditingController(),
        focusNode: FocusNode(),
      );
    }).toList());
  }

  String get concatText {
    String text = '';

    for (var element in list) {
      if (text.isEmpty) {
        text = element.textEditingController!.text;
      } else {
        text = '$text${element.textEditingController!.text}';
      }
    }

    return text;
  }

  void moveToNextFocus(int index) async {
    if (index == (list.length - 1)) {
      widget.onCompleted?.call(concatText);
    } else {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[index + 1].focusNode!);
      list[index + 1].textEditingController!.text = ' ';

      setTextSelection(index + 1);
    }
  }

  void moveToPreviousFocus(int index) async {
    if (index >= 1) {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[index - 1].focusNode!);

      setTextSelection(index - 1);
    } else {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[0].focusNode!);

      setTextSelection(0);
    }
  }

  void setTextSelection(int index) {
    currentIndex = index;

    list[index].textEditingController!.selection = TextSelection(
      baseOffset: 0,
      extentOffset: list[index].textEditingController!.text.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in list) {
      element.textEditingController?.dispose();
      element.focusNode?.dispose();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(list.length, (index) {
        return Container(
          width: widget.fieldWidth,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: widget.boxDecoration ??
              BoxDecoration(
                border: Border.all(
                  color: list[index].focusNode!.hasFocus
                      ? context.primaryColor
                      : Colors.white54,
                  width: list[index].focusNode!.hasFocus ? 2 : 1,
                ),
                borderRadius: radius(4),
              ),
          alignment: Alignment.center,
          child: TextField(
            controller: list[index].textEditingController,
            focusNode: list[index].focusNode,
            keyboardType: TextInputType.number,
            style: widget.textStyle,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            maxLength: 1,
            cursorColor: widget.cursorColor,
            decoration: widget.decoration ??
                InputDecoration(
                  border: widget.showUnderline ? null : InputBorder.none,
                  counter: Offstage(),
                  contentPadding: EdgeInsets.zero,
                ),
            textAlign: TextAlign.center,
            onSubmitted: (s) {
              if (s.isEmpty) {
                moveToPreviousFocus(index);
              } else if (s.length == 1) {
                if (s.contains(' ')) {
                  list[index].textEditingController!.text = '';
                  return;
                }
                moveToNextFocus(index);
              }
            },
            onChanged: (s) {
              if (s.isEmpty) {
                moveToPreviousFocus(index);
              } else if (s.length == 1) {
                if (s.contains(' ')) {
                  list[index].textEditingController!.text = '';
                }
                moveToNextFocus(index);
              }
              widget.onChanged?.call(concatText);

              setState(() {});
            },
            onTap: () async {
              context.unFocus(list[index].focusNode!);
              await 1.milliseconds.delay;
              context.requestFocus(list[index].focusNode!);

              setTextSelection(index);
            },
          ),
        );
      }),
    );
  }
}

class OTPLengthModel {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  OTPLengthModel({
    this.textEditingController,
    this.focusNode,
  });
}
