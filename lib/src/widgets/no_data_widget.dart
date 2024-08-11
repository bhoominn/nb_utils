import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

/// A widget used to display a message when there is no data available.
class NoDataWidget extends StatelessWidget {
  /// The URL or asset path of the image to display.
  final String? image;

  /// The size of the image to be displayed.
  final Size? imageSize;

  /// The BoxFit property for fitting the image within its container.
  final BoxFit fit;

  /// Custom widget to use as the image instead of an image URL or asset.
  final Widget? imageWidget;

  /// The title text to display in the widget.
  final String? title;

  /// The subtitle text to display in the widget.
  final String? subTitle;

  /// Custom text style for the title text.
  final TextStyle? titleTextStyle;

  /// Custom text style for the subtitle text.
  final TextStyle? subTitleTextStyle;

  /// Callback function to be executed when the retry button is pressed.
  final VoidCallback? onRetry;

  /// Text to display on the retry button.
  final String? retryText;

  /// Text Color for the retry button.
  final Color? retryButtonTextColor;

  /// Padding for the retry button.
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
    this.retryButtonTextColor,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.buttonPadding,
    super.key,
  });

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
            textColor: retryButtonTextColor ?? white,
            padding: buttonPadding ??
                EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            color: context.primaryColor,
          ),
      ],
    ).center();
  }

  /// Builds the image widget based on the image URL or asset path.
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
