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

  const NoDataWidget({
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _imageWidget(),
        16.height,
        if (title.validate().isNotEmpty)
          Text(title!,
              style: titleTextStyle ?? primaryTextStyle(),
              textAlign: TextAlign.center),
        4.height,
        if (subTitle.validate().isNotEmpty)
          Text(subTitle!,
              style: subTitleTextStyle ?? secondaryTextStyle(),
              textAlign: TextAlign.center),
        16.height,
        if (onRetry != null)
          AppButton(
            onTap: () {
              onRetry?.call();
            },
            text: retryText ?? 'Try again',
            textColor: white,
            padding: EdgeInsets.zero,
            color: context.primaryColor,
          ),
      ],
    ).center();
  }

  Widget _imageWidget() {
    if (imageWidget != null) return imageWidget!;
    if (image == null) return const Offstage();

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
