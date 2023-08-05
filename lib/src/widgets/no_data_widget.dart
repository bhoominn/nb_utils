import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NoDataWidget extends StatelessWidget {
  final String? image;
  final Size? imageSize;
  final BoxFit fit;
  final Widget? imageWidget;

  final String? title;
  final String? subTitle;

  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;

  final VoidCallback? onRetry;
  final String? retryText;
  final EdgeInsets? buttonPadding;

  NoDataWidget({
    this.image,
    this.imageSize,
    this.imageWidget,
    this.fit = BoxFit.contain,
    this.title,
    this.subTitle,
    this.onRetry,
    this.retryText,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.buttonPadding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _imageWidget(),
        if (title.validate().isNotEmpty)
          Text(
            title!,
            style: titleTextStyle ?? primaryTextStyle(),
            textAlign: TextAlign.center,
          ).paddingTop(16),
        if (subTitle.validate().isNotEmpty)
          Text(
            subTitle!,
            style: subTitleTextStyle ?? secondaryTextStyle(),
            textAlign: TextAlign.center,
          ).paddingTop(4),
        if (onRetry != null)
          AppButton(
            margin: EdgeInsets.only(top: 16),
            onTap: onRetry,
            text: retryText ?? 'Reload',
            textColor: white,
            padding: buttonPadding ??
                EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            color: context.primaryColor,
          ),
      ],
    ).center();
  }

  Widget _imageWidget() {
    if (imageWidget != null) return imageWidget!;
    if (image.validate().isEmpty) return Offstage();

    if (image.validate().startsWith('http')) {
      return Image.network(
        image!,
        height: imageSize != null ? (imageSize!.height) : 200,
        width: imageSize != null ? (imageSize!.width) : 200,
        fit: fit,
      );
    } else {
      return Image.asset(
        image!,
        height: imageSize != null ? (imageSize!.height) : 200,
        width: imageSize != null ? (imageSize!.width) : 200,
        fit: fit,
      );
    }
  }
}
