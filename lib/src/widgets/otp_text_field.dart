import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

/// A widget for entering and managing OTP (One Time Password) input.
class OTPTextField extends StatefulWidget {
  /// The length of the OTP code.
  final int pinLength;

  /// Callback function triggered when the OTP code changes.
  final Function(String)? onChanged;

  /// Callback function triggered when the OTP code is completed.
  final Function(String)? onCompleted;

  /// Flag to show/hide underline decoration for the OTP input fields.
  final bool showUnderline;

  /// Custom input decoration for the OTP input fields.
  final InputDecoration? decoration;

  /// Custom box decoration for the OTP input fields container.
  final BoxDecoration? boxDecoration;

  /// The width of each OTP input field.
  final double fieldWidth;

  /// Custom text style for the OTP input fields.
  final TextStyle? textStyle;

  /// The color of the cursor in the OTP input fields.
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
    super.key,
  });

  @override
  OTPTextFieldState createState() => OTPTextFieldState();
}

class OTPTextFieldState extends State<OTPTextField> {
  /// List to hold OTP input fields and focus nodes.
  List<OTPLengthModel> list = [];

  /// Focus node for the OTP input fields.
  FocusNode focusNode = FocusNode();

  /// Index of the current active OTP input field.
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the list with OTP input fields and focus nodes.
    list.addAll(List.generate(widget.pinLength, (index) {
      return OTPLengthModel(
        textEditingController: TextEditingController(),
        focusNode: FocusNode(),
      );
    }).toList());
  }

  /// Concatenates the text from all OTP input fields.
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

  /// Moves focus to the next OTP input field.
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

  /// Moves focus to the previous OTP input field.
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

  /// Sets text selection in the current OTP input field.
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
    // Dispose text editing controllers and focus nodes.
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

/// Model class to hold the text editing controller and focus node for each OTP input field.
class OTPLengthModel {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  OTPLengthModel({
    this.textEditingController,
    this.focusNode,
  });
}
