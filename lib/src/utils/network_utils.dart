import 'package:connectivity/connectivity.dart';
import 'package:nb_utils/nb_utils.dart';

/// return true is network is available
Future<bool> isNetworkAvailable() async {
  if (isMobile) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return false;
  }
  return true;
}
