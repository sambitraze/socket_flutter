import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_flutter/services/base_service.dart';

class AuthService extends BaseService {
  static Map<String, dynamic> _authDetails = {};
  static const String authNamespace = "auth";
  static Future<Map<String, dynamic>> getSavedAuth() async {
    if (AuthService._authDetails.isNotEmpty) {
      return _authDetails;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> auth = prefs.getString(authNamespace) != null
        ? json.decode(prefs.getString(authNamespace)!)
        : {};

    AuthService._authDetails = auth;
    return auth;
  }

  static Future<http.Response> makeAuthenticatedRequest(String url,
      {String method = 'POST',
      body,
      mergeDefaultHeader = true,
      Map<String, String>? extraHeaders}) async {
    try {
      Map<String, dynamic> auth = await getSavedAuth();
      extraHeaders ??= {};
      var sentHeaders = mergeDefaultHeader
          ? {
              ...BaseService.headers,
              ...extraHeaders,
              "Authorization": "Bearer ${auth['access_token']}"
            }
          : extraHeaders;

      switch (method) {
        case 'POST':
          body ??= {};
          return http.post(Uri.parse(url), headers: sentHeaders, body: body);

        case 'GET':
          return http.get(Uri.parse(url), headers: sentHeaders);

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

  static Future signIn(String email, String password) async {
    try {
      http.Response response = await BaseService.makeUnauthenticatedRequest(
          "${BaseService.BASE_URL}auth/login",
          method: "POST",
          body: json.encode({"email": email, "password": password}));
      var responseMap = json.decode(response.body);
      if (responseMap["status"] == "success") {
        _saveToken("access_token", "refresh_token", email,
            "bb878837-27a2-466d-a264-b9b2560c8aba");
      }
      return responseMap;
    } catch (err) {
      rethrow;
    }
  }

  static Future logout() async {
    try {
      http.Response response = await BaseService.makeUnauthenticatedRequest(
          "${BaseService.BASE_URL}auth/login",
          method: "POST",
          body: json.encode({"refresh_token": _authDetails['access_token']}));
      if (response.statusCode == 200) {
        clearAuth();
      } else {
        throw Exception("Something went wrong");
      }
    } catch (err) {
      rethrow;
    }
  }

  static _saveToken(String accessToken, String refreshToken, String email,
      String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        authNamespace,
        json.encode({
          "access_token": accessToken,
          "email": email,
          "refresh_token": refreshToken,
          "role": role
        }));
  }

  static clearAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _authDetails = {};
  }
}
