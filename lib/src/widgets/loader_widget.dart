import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// Circular Loader Widget
class Loader extends StatefulWidget {
  final Color? color;

  @Deprecated(
      'accentColor is now deprecated and not being used. use defaultLoaderAccentColorGlobal instead')
  final Color? accentColor;
  final Decoration? decoration;
  final int? size;
  final double? value;
  final Animation<Color?>? valueColor;

  Loader({
    this.color,
    this.decoration,
    this.size,
    this.value,
    this.valueColor,
    this.accentColor,
    Key? key,
  }) : super(key: key);

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: widget.size.validate(value: 40).toDouble(),
      width: widget.size.validate(value: 40).toDouble(),
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.color ?? defaultLoaderBgColorGlobal,
            shape: BoxShape.circle,
            boxShadow: defaultBoxShadow(),
          ),
      //Progress color uses accentColor from ThemeData
      child: CircularProgressIndicator(
        strokeWidth: 2,
        value: widget.value,
        valueColor: widget.valueColor ??
            AlwaysStoppedAnimation(
              defaultLoaderAccentColorGlobal ??
                  Theme.of(context).colorScheme.secondary,
            ),
      ),
    ).center();
  }
}
