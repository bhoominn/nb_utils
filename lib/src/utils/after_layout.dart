import 'package:flutter/material.dart';

/// Callback after build widget is rendered
/// CREDIT
/// https://pub.dev/packages/after_layout
@Deprecated('Use afterBuildCreated() instead')
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);

  @override
  void dispose() {
    super.dispose();
  }
}
