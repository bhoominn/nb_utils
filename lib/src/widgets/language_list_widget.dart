import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum WidgetType { DROPDOWN, LIST }

/// Use SELECTED_LANGUAGE_CODE Pref key to get selected language code
class LanguageListWidget extends StatefulWidget {
  final WidgetType widgetType;
  final Widget? trailing;

  /// You can set scrollPhysics to NeverScrollableScrollPhysics if you have SingleChildScroll already.
  final ScrollPhysics? scrollPhysics;
  final void Function(LanguageDataModel)? onLanguageChange;

  LanguageListWidget({
    this.widgetType = WidgetType.LIST,
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

  Widget build(BuildContext context) {
    Widget _buildImageWidget(String imagePath) {
      if (imagePath.startsWith('http')) {
        return Image.network(imagePath, width: 24);
      } else {
        return Image.asset(imagePath, width: 24);
      }
    }

    if (widget.widgetType == WidgetType.LIST) {
      return Container(
        child: ListView.builder(
          itemBuilder: (_, index) {
            LanguageDataModel data = localeLanguageList[index];

            return SettingItemWidget(
              title: data.name.validate(),
              subTitle: data.subTitle,
              leading:
                  (data.flag != null) ? _buildImageWidget(data.flag!) : null,
              trailing: Container(
                child: widget.trailing ??
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: boxDecorationDefault(shape: BoxShape.circle),
                      child: Icon(Icons.check, size: 15, color: Colors.black),
                    ),
              ).visible(getStringAsync(SELECTED_LANGUAGE_CODE) ==
                  data.languageCode.validate()),
              onTap: () async {
                await setValue(SELECTED_LANGUAGE_CODE, data.languageCode);

                selectedLanguageDataModel = data;

                setState(() {});
                widget.onLanguageChange?.call(data);
              },
            );
          },
          shrinkWrap: true,
          physics: widget.scrollPhysics,
          itemCount: localeLanguageList.length,
        ),
      );
    } else {
      return DropdownButton<LanguageDataModel>(
        value: selectedLanguageDataModel,
        dropdownColor: context.cardColor,
        elevation: defaultElevation,
        onChanged: (LanguageDataModel? data) async {
          selectedLanguageDataModel = data;

          await setValue(SELECTED_LANGUAGE_CODE, data!.languageCode.validate());

          setState(() {});
          widget.onLanguageChange?.call(data);
        },
        items: localeLanguageList.map((data) {
          return DropdownMenuItem<LanguageDataModel>(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data.flag != null) _buildImageWidget(data.flag!),
                4.width,
                Text(data.name.validate(), style: primaryTextStyle()),
              ],
            ),
            value: data,
          );
        }).toList(),
      );
    }
  }
}
