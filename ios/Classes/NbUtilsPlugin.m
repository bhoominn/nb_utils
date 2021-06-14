#import "NbUtilsPlugin.h"
#if __has_include(<nb_utils/nb_utils-Swift.h>)
#import <nb_utils/nb_utils-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nb_utils-Swift.h"
#endif

@implementation NbUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNbUtilsPlugin registerWithRegistrar:registrar];
}
@end
