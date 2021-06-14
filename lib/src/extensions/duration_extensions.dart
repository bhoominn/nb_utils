import 'dart:async';

extension GetDurationUtils on Duration {
  ///  await Duration(seconds: 1).delay();
  Future<void> get delay => Future.delayed(this);
}
