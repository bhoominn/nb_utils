import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/utils/platform_info_stub.dart'
    if (dart.library.io) 'package:nb_utils/src/utils/platform_info_io.dart';

enum DeviceSize { mobile, tablet, desktop }

extension LayoutUtils on BoxConstraints {
  /// returns DeviceSize
  DeviceSize get device {
    if (maxWidth >= desktopBreakpointGlobal) {
      return DeviceSize.desktop;
    }
    if (maxWidth >= tabletBreakpointGlobal) {
      return DeviceSize.tablet;
    }
    return DeviceSize.mobile;
  }
}

/// return true if running on Web
bool get isWeb => kIsWeb;

/// return true if running on Mobile OS
bool get isMobile =>
    !isWeb &&
    ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.android));

/// return true if running on Desktop
bool get isDesktop =>
    !isWeb &&
    ((defaultTargetPlatform == TargetPlatform.macOS) ||
        (defaultTargetPlatform == TargetPlatform.windows) ||
        (defaultTargetPlatform == TargetPlatform.linux));

/// return true if running on iOS or macOS
bool get isApple =>
    !isWeb &&
    ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.macOS));

/// return true if running on Android of Fuchsia
bool get isGoogle =>
    !isWeb &&
    ((defaultTargetPlatform == TargetPlatform.android) ||
        (defaultTargetPlatform == TargetPlatform.fuchsia));

/// return true if running on Android
bool get isAndroid =>
    !isWeb && (defaultTargetPlatform == TargetPlatform.android);

@Deprecated('Use isIOS instead')
bool get isIos => !isWeb && (defaultTargetPlatform == TargetPlatform.iOS);

/// return true if running on iOS
bool get isIOS => !isWeb && (defaultTargetPlatform == TargetPlatform.iOS);

/// return true if running on macOs
bool get isMacOS => !isWeb && (defaultTargetPlatform == TargetPlatform.macOS);

/// return true if running on Linux
bool get isLinux => !isWeb && (defaultTargetPlatform == TargetPlatform.linux);

/// return true if running on Windows
bool get isWindows =>
    !isWeb && (defaultTargetPlatform == TargetPlatform.windows);

/// return OS name
String get operatingSystemName => platformOperatingSystem;

/// return OS version
String get operatingSystemVersion => platformOperatingSystemVersion;
