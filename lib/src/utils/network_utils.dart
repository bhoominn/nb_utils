import 'package:connectivity/connectivity.dart';
import 'package:nb_utils/nb_utils.dart';

/// return true if network is available
Future<bool> isNetworkAvailable() async {
  if (isMobile || isMacOS || isWeb) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
  return true;
}

/// return true if connected to mobile
Future<bool> isConnectedToMobile() async {
  if (isMobile || isMacOS || isWeb) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile;
  }
  return true;
}

/// return true if connected to wifi
Future<bool> isConnectedToWiFi() async {
  if (isMobile || isMacOS || isWeb) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.wifi;
  }
  return true;
}
