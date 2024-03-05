import 'package:http/http.dart';

enum IPAddressFormat { json, string }

Future<dynamic> getIPAddress(
    {IPAddressFormat ipAddressFormat = IPAddressFormat.json,
    String defaultErrorMessage = 'Not able to find the IP Address.'}) async {
  try {
    var response = await get(Uri.parse('https://api64.ipify.org'));
    if (response.statusCode == 200) {
      if (ipAddressFormat == IPAddressFormat.json) {
        return handleJSONResponse(status: true, value: response.body);
      } else {
        return response.body;
      }
    } else {
      return handleJSONResponse(status: false, value: defaultErrorMessage);
    }
  } catch (_) {
    return handleJSONResponse(status: false, value: defaultErrorMessage);
  }
}

Map<String, dynamic> handleJSONResponse(
    {bool status = false, String value = ''}) {
  return {
    'status': true,
    'ip_address': value,
  };
}
