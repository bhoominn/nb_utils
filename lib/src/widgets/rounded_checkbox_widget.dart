import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

///Widget that draw a beautiful checkbox rounded. Provided with animation if wanted
class RoundedCheckBox extends StatefulWidget {
  const RoundedCheckBox({
    Key? key,
    this.isChecked,
    this.checkedWidget,
    this.uncheckedWidget,
    this.checkedColor,
    this.uncheckedColor,
    this.disabledColor,
    this.border,
    this.borderColor,
    this.size,
    this.animationDuration,
    this.onTap,
    this.text = '',
    this.textStyle,
  }) : super(key: key);

  ///Define weather the checkbox is marked or not
  final bool? isChecked;

  ///Define the widget that is shown when Widgets is checked
  final Widget? checkedWidget;

  ///Define the widget that is shown when Widgets is unchecked
  final Widget? uncheckedWidget;

  ///Define the color that is shown when Widgets is checked
  final Color? checkedColor;

  ///Define the color that is shown when Widgets is unchecked
  final Color? uncheckedColor;

  ///Define the color that is shown when Widgets is disabled
  final Color? disabledColor;

  ///Define the border of the widget
  final Border? border;

  ///Define the border color  of the widget
  final Color? borderColor;

  ///Define the size of the checkbox
  final double? size;

  final String text;
  final TextStyle? textStyle;

  ///Define Function that os executed when user tap on checkbox
  ///If onTap is given a null callback, it will be disabled
  final Function(bool?)? onTap;

  ///Define the duration of the animation. If any
  final Duration? animationDuration;

  @override
  _RoundedCheckBoxState createState() => _RoundedCheckBoxState();
}

class _RoundedCheckBoxState extends State<RoundedCheckBox> {
  bool? isChecked;
  late Duration animationDuration;
  double? size;
  Widget? checkedWidget;
  Widget? uncheckedWidget;
  Color? checkedColor;
  Color? uncheckedColor;
  Color? disabledColor;
  late Color borderColor;

  @override
  void initState() {
    isChecked = widget.isChecked ?? false;
    animationDuration = widget.animationDuration ?? Duration(milliseconds: 500);
    size = widget.size ?? 24.0;
    checkedColor = widget.checkedColor ?? Colors.green;
    uncheckedColor = widget.uncheckedColor;
    borderColor = widget.borderColor ?? Colors.grey;
    checkedWidget = widget.checkedWidget ??
        Icon(Icons.check, color: Colors.white, size: size! - 6);
    uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap != null
          ? () {
              setState(() => isChecked = !isChecked!);
              widget.onTap?.call(isChecked);
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size! / 2),
            child: AnimatedContainer(
              duration: animationDuration,
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: isChecked! ? checkedColor : uncheckedColor,
                border: widget.border ??
                    Border.all(
                      color: borderColor,
                    ),
                borderRadius: BorderRadius.circular(size! / 2),
              ),
              child: isChecked! ? checkedWidget! : uncheckedWidget!,
            ),
          ),
          if (widget.text.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.width,
                Text(widget.text, style: widget.textStyle ?? primaryTextStyle())
                    .flexible(),
              ],
            ).flexible(),
        ],
      ),
    );
  }
}
