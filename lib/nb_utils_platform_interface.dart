import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nb_utils_method_channel.dart';

abstract class NbUtilsPlatform extends PlatformInterface {
  /// Constructs a NbUtilsPlatform.
  NbUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static NbUtilsPlatform _instance = MethodChannelNbUtils();

  /// The default instance of [NbUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelNbUtils].
  static NbUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NbUtilsPlatform] when
  /// they register themselves.
  static set instance(NbUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
