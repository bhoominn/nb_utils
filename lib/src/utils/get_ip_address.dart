import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

/// Enum representing the format in which the IP address should be retrieved.
enum IPAddressFormat {
  /// IP address will be returned in JSON format.
  json,

  /// IP address will be returned as a string.
  string,
}

enum IPAddressVersion { v4, v6, v64 }

/// Retrieves the public IP address using the ipify API.
///
/// Parameters:
///   - ipAddressFormat: (Optional) The format in which the IP address should be retrieved,
///                      defaults to IPAddressFormat.json.
///   - defaultErrorMessage: (Optional) The default error message to return if IP address retrieval fails,
///                          defaults to 'Not able to find the IP Address.'.
///
/// Returns:
///   A Future containing the IP address in the specified format,
///   or a default error message if retrieval fails.
Future<dynamic> getIPAddress({
  IPAddressFormat ipAddressFormat = IPAddressFormat.string,
  String defaultErrorMessage = 'Not able to find the IP Address.',
  IPAddressVersion ipAddressVersion = IPAddressVersion.v64,
}) async {
  try {
    var response = await get(Uri.parse(_getURl(ipAddressVersion)));

    if (ipAddressFormat == IPAddressFormat.json) {
      if (response.statusCode.isSuccessful()) {
        return handleJSONResponse(status: true, value: response.body);
      } else {
        return handleJSONResponse(status: false, value: defaultErrorMessage);
      }
    } else if (ipAddressFormat == IPAddressFormat.string) {
      if (response.statusCode.isSuccessful()) {
        return response.body;
      } else {
        throw defaultErrorMessage;
      }
    }
  } catch (_) {
    if (ipAddressFormat == IPAddressFormat.json) {
      return handleJSONResponse(status: false, value: defaultErrorMessage);
    } else {
      throw defaultErrorMessage;
    }
  }
}

/// Handles the JSON response for IP address retrieval.
///
/// Returns:
///   A Map representing the JSON response with 'status' and 'ip_address' keys.
Map<String, dynamic> handleJSONResponse({
  bool status = false,
  String value = '',
}) {
  return {
    'status': status,
    'ip_address': value,
  };
}

String _getURl(IPAddressVersion ipAddressVersion) {
  if (ipAddressVersion == IPAddressVersion.v64) {
    return 'https://api64.ipify.org';
  } else if (ipAddressVersion == IPAddressVersion.v4) {
    return 'https://api4.ipify.org';
  } else if (ipAddressVersion == IPAddressVersion.v6) {
    return 'https://api6.ipify.org';
  }
  return 'https://api64.ipify.org';
}
