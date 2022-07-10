import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  var packInfo = [String: String]()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let nbUtilsChannel = FlutterMethodChannel(name: "nb_utils",binaryMessenger: controller.binaryMessenger)

    nbUtilsChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if(call.method == "packageInfo") {
            self.packInfo = ["packageName": Bundle.main.bundleIdentifier!,"versionCode": Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String, "versionName": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String];

            result(self.packInfo);
        } else {
            result("")
        }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
