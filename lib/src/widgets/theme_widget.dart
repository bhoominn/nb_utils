import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum ThemeModes { SystemDefault, Light, Dark }

// ThemeWidget
class ThemeWidget extends StatefulWidget {
  final ScrollPhysics? scrollPhysics;
  final void Function(int)? onThemeChanged;
  final String? subTitle;
  final Widget? trailing;
  final EdgeInsets? padding;

  ThemeWidget({
    this.scrollPhysics,
    this.onThemeChanged,
    this.subTitle,
    this.trailing,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  _ThemeWidgetState createState() => _ThemeWidgetState();
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
                  padding: EdgeInsets.all(2),
                  decoration: boxDecorationDefault(shape: BoxShape.circle),
                  child: Icon(Icons.check, size: 15, color: Colors.black),
                ),
          ).visible(getIntAsync(THEME_MODE_INDEX) == index),
          onTap: () async {
            await setValue(THEME_MODE_INDEX, index);
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
    case ThemeModes.Light:
      name = 'Light';
      break;
    case ThemeModes.Dark:
      name = 'Dark';
      break;
    case ThemeModes.SystemDefault:
      name = 'System Default';
      break;
  }
  return name;
}

String? get getSelectedThemeMode {
  String? data;

  ThemeModes.values.forEach((element) {
    if (ThemeModes.values.indexOf(element) == getIntAsync(THEME_MODE_INDEX)) {
      data = _getName(element);
    }
  });

  return data;
}
