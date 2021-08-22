import 'package:flutter/material.dart';

@Deprecated('Use IndexedStack instead')
class PersistentTabs extends StatelessWidget {
  const PersistentTabs({
    required this.widgets,
    this.currentIndex = 0,
  });

  final int currentIndex;
  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widgets.map((w) {
        return Offstage(
          offstage: currentIndex != widgets.indexOf(w),
          child: w,
        );
      }).toList(),
    );
  }
}
