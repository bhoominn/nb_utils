import 'package:flutter/material.dart';

class WalkThroughModelClass {
  String? title;
  String? subTitle;
  Color? color;

  /// Can be image url or asset path
  String? image;

  WalkThroughModelClass({
    this.title,
    this.subTitle,
    this.image,
    this.color,
  });
}
