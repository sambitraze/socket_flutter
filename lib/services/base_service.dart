import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseService {
  // ignore: constant_identifier_names
  static const BASE_URL = "https://admin.ezchat.agpro.co.in/";
  static final Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  static Future getAppCurrentVersion() async {
    http.Response response =
        await http.get(Uri.parse("$BASE_URL/items/version"));
    var responseMap = json.decode(response.body);
    return responseMap["data"]["version"].toString();
  }

  static Future<http.Response> makeUnauthenticatedRequest(String url,
      {String method = 'POST',
      body,
      mergeDefaultHeader = true,
      Map<String, String>? extraHeaders}) async {
    try {
      extraHeaders ??= {};
      var sentHeaders =
          mergeDefaultHeader ? {...headers, ...extraHeaders} : extraHeaders;

      switch (method) {
        case 'POST':
          body ??= {};
          return http.post(Uri.parse(url), headers: sentHeaders, body: body);

        case 'GET':
          return http.get(Uri.parse(url), headers: headers);

        case 'PUT':
          return http.put(Uri.parse(url), headers: sentHeaders, body: body);

        case 'DELETE':
          return http.delete(Uri.parse(url), headers: sentHeaders);

        default:
          return http.post(Uri.parse(url), headers: sentHeaders, body: body);
      }
    } catch (err) {
      rethrow;
    }
  }
}
