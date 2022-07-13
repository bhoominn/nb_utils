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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(children.validate().length, (index) {
        return Container(
          padding: edgeInsets ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: symbolType == SymbolType.Numbered
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              symbolType == SymbolType.Bullet
                  ? Text(
                      '•',
                      style: boldTextStyle(
                          color: symbolColor ?? textPrimaryColorGlobal,
                          size: 24),
                    )
                  : SizedBox(),
              symbolType == SymbolType.Numbered
                  ? Text('${prefixText.validate()} ${index + 1}.',
                      style: boldTextStyle(
                          color: symbolColor ?? textPrimaryColorGlobal))
                  : SizedBox(),
              (symbolType == SymbolType.Custom && customSymbol != null)
                  ? customSymbol!
                  : SizedBox(),
              SizedBox(width: padding),
              children![index].expand(),
            ],
          ),
        );
      }),
    );
  }
}
