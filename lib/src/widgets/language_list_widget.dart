import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum WidgetType { dropdown, list }

/// Use SELECTED_LANGUAGE_CODE Pref key to get selected language code
class LanguageListWidget extends StatefulWidget {
  final WidgetType widgetType;
  final Widget? trailing;

  /// You can set scrollPhysics to NeverScrollableScrollPhysics if you have SingleChildScroll already.
  final ScrollPhysics? scrollPhysics;
  final void Function(LanguageDataModel)? onLanguageChange;

  const LanguageListWidget({
    this.widgetType = WidgetType.list,
    this.onLanguageChange,
    this.scrollPhysics,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  LanguageListWidgetState createState() => LanguageListWidgetState();
}

class LanguageListWidgetState extends State<LanguageListWidget> {
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
    Widget buildImageWidget(String imagePath) {
      if (imagePath.startsWith('http')) {
        return Image.network(imagePath, width: 24);
      } else {
        return Image.asset(imagePath, width: 24);
      }
    }

    if (widget.widgetType == WidgetType.list) {
      return ListView.builder(
        itemBuilder: (_, index) {
          LanguageDataModel data = localeLanguageList[index];

          return SettingItemWidget(
            title: data.name.validate(),
            subTitle: data.subTitle,
            leading: (data.flag != null) ? buildImageWidget(data.flag!) : null,
            trailing: Container(
              child: widget.trailing ??
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: boxDecorationDefault(shape: BoxShape.circle),
                    child:
                        const Icon(Icons.check, size: 15, color: Colors.black),
                  ),
            ).visible(getStringAsync(selectedLanguageCode) ==
                data.languageCode.validate()),
            onTap: () async {
              await setValue(selectedLanguageCode, data.languageCode);

              selectedLanguageDataModel = data;

              setState(() {});
              widget.onLanguageChange?.call(data);
            },
          );
        },
        shrinkWrap: true,
        physics: widget.scrollPhysics,
        itemCount: localeLanguageList.length,
      );
    } else {
      return DropdownButton<LanguageDataModel>(
        value: selectedLanguageDataModel,
        dropdownColor: context.cardColor,
        elevation: defaultElevation,
        onChanged: (LanguageDataModel? data) async {
          selectedLanguageDataModel = data;

          await setValue(selectedLanguageCode, data!.languageCode.validate());

          setState(() {});
          widget.onLanguageChange?.call(data);
        },
        items: localeLanguageList.map((data) {
          return DropdownMenuItem<LanguageDataModel>(
            value: data,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data.flag != null) buildImageWidget(data.flag!),
                4.width,
                Text(data.name.validate(), style: primaryTextStyle()),
              ],
            ),
          );
        }).toList(),
      );
    }
  }
}
