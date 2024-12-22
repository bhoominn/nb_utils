#include "include/nb_utils/nb_utils_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "nb_utils_plugin.h"

void NbUtilsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  nb_utils::NbUtilsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
