import 'package:http/http.dart';

/// Enum representing the format in which the IP address should be retrieved.
enum IPAddressFormat {
  /// IP address will be returned in JSON format.
  json,

  /// IP address will be returned as a string.
  string,
}

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
  IPAddressFormat ipAddressFormat = IPAddressFormat.json,
  String defaultErrorMessage = 'Not able to find the IP Address.',
}) async {
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

/// Handles the JSON response for IP address retrieval.
///
/// Parameters:
///   - status: (Optional) The status of the response, defaults to false.
///   - value: (Optional) The value to include in the response, defaults to an empty string.
///
/// Returns:
///   A Map representing the JSON response with 'status' and 'ip_address' keys.
Map<String, dynamic> handleJSONResponse({
  bool status = false,
  String value = '',
}) {
  return {
    'status': true,
    'ip_address': value,
  };
}
