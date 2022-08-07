import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class OTPTextField extends StatefulWidget {
  final int pinLength;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  final bool showUnderline;
  final Decoration? decoration;

  final double fieldWidth;

  OTPTextField({
    this.pinLength = 4,
    this.fieldWidth = 40,
    this.onChanged,
    this.onCompleted,
    this.showUnderline = false,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  OTPTextFieldState createState() => OTPTextFieldState();
}

class OTPTextFieldState extends State<OTPTextField> {
  List<OTPLengthModel> list = [];
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    list.addAll(List.generate(widget.pinLength, (index) {
      return OTPLengthModel(
          textEditingController: TextEditingController(),
          focusNode: FocusNode());
    }).toList());
  }

  String get concatText {
    String text = '';

    list.forEach((element) {
      if (text.isEmpty) {
        text = element.textEditingController!.text;
      } else {
        text = '$text${element.textEditingController!.text}';
      }
    });

    return text;
  }

  void moveToNextFocus(int index) async {
    if (index == (list.length - 1)) {
      widget.onCompleted?.call(concatText);
    } else {
      context.unFocus(list[index].focusNode!);
      context.requestFocus(list[index + 1].focusNode!);

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
    list[index].textEditingController!.selection = TextSelection(
      baseOffset: 0,
      extentOffset: list[index].textEditingController!.text.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    list.forEach((element) {
      element.textEditingController?.dispose();
      element.focusNode?.dispose();
    });
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
          decoration: BoxDecoration(
            border: Border.all(
                color: list[index].focusNode!.hasFocus
                    ? context.primaryColor
                    : Colors.grey.shade300),
            borderRadius: radius(),
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: list[index].textEditingController,
            focusNode: list[index].focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            ],
            maxLength: 1,
            decoration: InputDecoration(
              border: widget.showUnderline ? null : InputBorder.none,
              counter: Offstage(),
              contentPadding: EdgeInsets.zero,
            ),
            textAlign: TextAlign.center,
            onSubmitted: (s) {
              if (s.isEmpty) {
                moveToPreviousFocus(index);
              } else if (s.length == 1) {
                moveToNextFocus(index);
              }
            },
            onChanged: (s) {
              if (s.isEmpty) {
                moveToPreviousFocus(index);
              } else if (s.length == 1) {
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
