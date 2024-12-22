import 'package:flutter_test/flutter_test.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/nb_utils_platform_interface.dart';
import 'package:nb_utils/nb_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNbUtilsPlatform
    with MockPlatformInterfaceMixin
    implements NbUtilsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NbUtilsPlatform initialPlatform = NbUtilsPlatform.instance;

  test('$MethodChannelNbUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNbUtils>());
  });

  test('getPlatformVersion', () async {
    NbUtils nbUtilsPlugin = NbUtils();
    MockNbUtilsPlatform fakePlatform = MockNbUtilsPlatform();
    NbUtilsPlatform.instance = fakePlatform;

    expect(await nbUtilsPlugin.getPlatformVersion(), '42');
  });
}
