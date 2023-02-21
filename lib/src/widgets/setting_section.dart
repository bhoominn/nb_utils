import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// SettingSection
class SettingSection extends StatelessWidget {
  final Widget? title;
  final Widget? subTitle;
  final Decoration? headingDecoration;
  final EdgeInsets? headerPadding;

  final Widget? divider;

  final List<Widget> items;
  final WrapCrossAlignment? crossAxisAlignment;

  const SettingSection({
    required this.items,
    this.crossAxisAlignment,
    this.headingDecoration,
    this.headerPadding,
    this.divider,
    this.title,
    this.subTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: headerPadding ?? const EdgeInsets.all(16),
          decoration: headingDecoration ??
              const BoxDecoration(color: Color(0xFFECECEC)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) title!,
              if (subTitle != null) 4.height,
              if (subTitle != null) subTitle!,
            ],
          ),
        ),
        divider ?? const Divider(height: 0),
        Wrap(
          crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
          children: items,
        ),
      ],
    );
  }
}
