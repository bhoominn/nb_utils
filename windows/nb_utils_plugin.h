#ifndef FLUTTER_PLUGIN_NB_UTILS_PLUGIN_H_
#define FLUTTER_PLUGIN_NB_UTILS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace nb_utils {

class NbUtilsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NbUtilsPlugin();

  virtual ~NbUtilsPlugin();

  // Disallow copy and assign.
  NbUtilsPlugin(const NbUtilsPlugin&) = delete;
  NbUtilsPlugin& operator=(const NbUtilsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace nb_utils

#endif  // FLUTTER_PLUGIN_NB_UTILS_PLUGIN_H_
