import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum SymbolType { Bullet, Numbered, Custom }

/// Add UL to its children
class UL extends StatelessWidget {
  final List<Widget>? children;
  final double padding;
  final double spacing;
  final SymbolType symbolType;
  final Color? symbolColor;
  final Color? textColor;
  final EdgeInsets? edgeInsets;
  final Widget? customSymbol;
  final CrossAxisAlignment? symbolCrossAxisAlignment;
  final String? prefixText; // Used when SymbolType is Numbered

  UL({
    this.children,
    this.padding = 8,
    this.spacing = 8,
    this.symbolType = SymbolType.Bullet,
    this.symbolColor,
    this.textColor,
    this.customSymbol,
    this.prefixText,
    this.edgeInsets,
    this.symbolCrossAxisAlignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(children.validate().length, (index) {
        return Padding(
          padding: edgeInsets ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment:
                symbolCrossAxisAlignment ?? CrossAxisAlignment.start,
            children: [
              symbolWidget(index),
              SizedBox(width: padding),
              children![index].expand(),
            ],
          ),
        );
      }),
    );
  }

  /// Returns a symbol widget
  Widget symbolWidget(int index) {
    if (symbolType == SymbolType.Numbered && customSymbol != null) {
      return customSymbol!;
    } else if (symbolType == SymbolType.Bullet) {
      return Text(
        '•',
        style: boldTextStyle(
          color: symbolColor ?? textPrimaryColorGlobal,
          //size: 24,
        ),
      );
    } else if (symbolType == SymbolType.Numbered) {
      return Text(
        '${prefixText.validate()} ${index + 1}.',
        style: boldTextStyle(
          color: symbolColor ?? textPrimaryColorGlobal,
        ),
      );
    }

    return Offstage();
  }
}
