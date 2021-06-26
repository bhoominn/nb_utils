import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ToastUtil {
  static final int lengthShort = 2;
  static final int lengthLong = 4;
  static final int bottom = 0;
  static final int center = 1;
  static final int top = 2;

  static void show(
    String msg,
    BuildContext context, {
    int? duration = 2,
    int? gravity = 0,
    Color backgroundColor = const Color(0x8CFFFFFF),
    textStyle = const TextStyle(fontSize: 15, color: Colors.black),
    double backgroundRadius = 20,
    bool? rootNavigator,
    Border? border,
  }) {
    ToastView.dismiss();
    ToastView.createView(msg, context, duration, gravity, backgroundColor,
        textStyle, backgroundRadius, border, rootNavigator);
  }
}

class ToastView {
  static final ToastView _singleton = ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String msg,
      BuildContext context,
      int? duration,
      int? gravity,
      Color background,
      TextStyle textStyle,
      double backgroundRadius,
      Border? border,
      bool? rootNavigator) async {
    overlayState = Overlay.of(context, rootOverlay: rootNavigator ?? false);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(backgroundRadius),
                  border: border,
                  boxShadow:
                      defaultBoxShadow(spreadRadius: 1.0, blurRadius: 1.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Text(msg, softWrap: true, style: textStyle),
              ),
            ),
          ),
          gravity: gravity,
        );
      },
    );
    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(
        Duration(seconds: duration == null ? ToastUtil.lengthShort : duration));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key? key,
    required this.widget,
    required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int? gravity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: gravity == 2 ? MediaQuery.of(context).viewInsets.top + 50 : null,
      bottom:
          gravity == 0 ? MediaQuery.of(context).viewInsets.bottom + 50 : null,
      child: Material(color: Colors.transparent, child: widget),
    );
  }
}
