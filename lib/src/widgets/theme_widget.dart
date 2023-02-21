import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum ThemeModes { systemDefault, light, dark }

// ThemeWidget
class ThemeWidget extends StatefulWidget {
  final ScrollPhysics? scrollPhysics;
  final void Function(int)? onThemeChanged;
  final String? subTitle;
  final Widget? trailing;
  final EdgeInsets? padding;

  const ThemeWidget({
    this.scrollPhysics,
    this.onThemeChanged,
    this.subTitle,
    this.trailing,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ThemeModes.values.length,
      physics: widget.scrollPhysics,
      padding: widget.padding ?? EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: _getName(ThemeModes.values[index]),
          subTitle: widget.subTitle,
          trailing: Container(
            child: widget.trailing ??
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: boxDecorationDefault(shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 15, color: Colors.black),
                ),
          ).visible(getIntAsync(themeModeIndex) == index),
          onTap: () async {
            await setValue(themeModeIndex, index);
            setState(() {});

            widget.onThemeChanged?.call(index);
          },
        );
      },
    );
  }
}

String _getName(ThemeModes themeModes) {
  String name = '';
  switch (themeModes) {
    case ThemeModes.light:
      name = 'Light';
      break;
    case ThemeModes.dark:
      name = 'Dark';
      break;
    case ThemeModes.systemDefault:
      name = 'System Default';
      break;
  }
  return name;
}

String? get getSelectedThemeMode {
  String? data;

  for (var element in ThemeModes.values) {
    if (ThemeModes.values.indexOf(element) == getIntAsync(themeModeIndex)) {
      data = _getName(element);
    }
  }

  return data;
}
