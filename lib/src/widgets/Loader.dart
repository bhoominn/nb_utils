import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// Circular Loader Widget
class Loader extends StatefulWidget {
  final Color? color;
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
  });

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
      child: Theme(
        data: ThemeData(
            accentColor: widget.accentColor ??
                (defaultLoaderAccentColorGlobal ??
                    Theme.of(context).accentColor)),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: widget.value,
          valueColor: widget.valueColor,
        ),
      ),
    ).center();
  }
}
