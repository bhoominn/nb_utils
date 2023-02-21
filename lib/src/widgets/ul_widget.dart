import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

enum SymbolType { bullet, numbered, custom }

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

  const UL({
    this.children,
    this.padding = 8,
    this.spacing = 8,
    this.symbolType = SymbolType.bullet,
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
        return Container(
          padding: edgeInsets ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment:
                symbolCrossAxisAlignment ?? CrossAxisAlignment.start,
            children: [
              symbolType == SymbolType.bullet
                  ? Text(
                      '•',
                      style: boldTextStyle(
                          color: symbolColor ?? textPrimaryColorGlobal,
                          size: 24),
                    )
                  : const SizedBox(),
              symbolType == SymbolType.numbered
                  ? Text('${prefixText.validate()} ${index + 1}.',
                      style: boldTextStyle(
                          color: symbolColor ?? textPrimaryColorGlobal))
                  : const SizedBox(),
              (symbolType == SymbolType.custom && customSymbol != null)
                  ? customSymbol!
                  : const SizedBox(),
              SizedBox(width: padding),
              children![index].expand(),
            ],
          ),
        );
      }),
    );
  }
}
