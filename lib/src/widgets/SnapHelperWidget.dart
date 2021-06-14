import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SnapHelperWidget<T> extends StatelessWidget {
  final dynamic initialData;
  final Future<T>? future;
  final Widget Function(T data) onSuccess;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final String? defaultErrorMessage;
  final bool useConnectionStateForLoader;

  SnapHelperWidget({
    required this.future,
    required this.onSuccess,
    this.loadingWidget,
    this.errorWidget,
    this.initialData,
    this.defaultErrorMessage,
    this.useConnectionStateForLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snap) {
        if (!useConnectionStateForLoader) {
          if (snap.hasData) {
            return onSuccess(snap.data!);
          } else {
            return snapWidgetHelper(
              snap,
              errorWidget: errorWidget,
              loadingWidget: loadingWidget,
              defaultErrorMessage: defaultErrorMessage,
            );
          }
        } else {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return loadingWidget ?? Loader();
            case ConnectionState.done:
              if (snap.hasData) {
                return onSuccess(snap.data!);
              } else {
                return errorWidget ??
                    Text(defaultErrorMessage ?? snap.error.toString(),
                            style: primaryTextStyle())
                        .center();
              }
            default:
              return SizedBox();
          }
        }
      },
    );
  }
}
