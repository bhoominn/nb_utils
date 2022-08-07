import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// SnapHelperWidget makes easy implementation for future or stream builder
class SnapHelperWidget<T> extends StatelessWidget {
  final dynamic initialData;
  final Future<T>? future;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final String? defaultErrorMessage;
  final bool useConnectionStateForLoader;
  final Widget Function(String)? errorBuilder;

  SnapHelperWidget({
    required this.future,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
    this.initialData,
    this.defaultErrorMessage,
    this.errorBuilder,
    this.useConnectionStateForLoader = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snap) {
        if (!useConnectionStateForLoader) {
          if (snap.hasData) {
            if (snap.data != null) {
              return onSuccess(snap.data!);
            } else {
              return snapWidgetHelper(
                snap,
                errorWidget: errorWidget,
                loadingWidget: loadingWidget,
                defaultErrorMessage: defaultErrorMessage,
                errorBuilder: errorBuilder,
              );
            }
          } else {
            return snapWidgetHelper(
              snap,
              errorWidget: errorWidget,
              loadingWidget: loadingWidget,
              defaultErrorMessage: defaultErrorMessage,
              errorBuilder: errorBuilder,
            );
          }
        } else {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loadingWidget ?? Loader();
            case ConnectionState.done:
              if (snap.hasData) {
                if (snap.data != null) {
                  return onSuccess(snap.data!);
                } else {
                  return snapWidgetHelper(
                    snap,
                    errorWidget: errorWidget,
                    loadingWidget: loadingWidget,
                    defaultErrorMessage: defaultErrorMessage,
                    errorBuilder: errorBuilder,
                  );
                }
              } else {
                if (errorBuilder != null) {
                  return errorBuilder!
                      .call(defaultErrorMessage ?? snap.error.toString());
                }
                return errorWidget ??
                    Text(
                      defaultErrorMessage ?? snap.error.toString(),
                      style: primaryTextStyle(),
                    ).center();
              }
            default:
              return SizedBox();
          }
        }
      },
    );
  }
}
