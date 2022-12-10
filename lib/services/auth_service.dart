import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_flutter/screens/intro_screen.dart';
import 'package:socket_flutter/screens/landing_screen.dart';
import 'package:socket_flutter/services/base_service.dart';
import 'package:socket_flutter/utils/show_toast.dart';

class AuthService extends BaseService {
  static Map<String, dynamic> _authDetails = {};
  static const String authNamespace = "auth";
  static const String expiryNamespace = "expiry";
  static const String userNamespace = "user";
  static const String emailNamespace = "email";

  static Future<DateTime> getExpiry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(expiryNamespace)) {
      var expiryString = prefs.getString(expiryNamespace);
      return DateTime.parse(expiryString!);
    } else {
      return DateTime.now();
    }
  }

  static Future<Map<String, dynamic>> getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(userNamespace)) {
      return {};
    } else {
      return json.decode(prefs.getString(userNamespace)!);
    }
  }

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

  static Future refreshAuth() async {
    await getSavedAuth();
    http.Response response = await BaseService.makeUnauthenticatedRequest(
      "${BaseService.BASE_URL}auth/refresh",
      method: "POST",
      body: json.encode(
        {"refresh_token": _authDetails["refresh_token"]},
      ),
    );
    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      _saveToken(responseMap["data"]["access_token"],
          responseMap["data"]["refresh_token"]);
    } else {
      throw Exception("Could not refresh token");
    }
  }

  static Future<http.Response> makeAuthenticatedRequest(String url,
      {String method = 'POST',
      body,
      mergeDefaultHeader = true,
      Map<String, String>? extraHeaders}) async {
    try {
      DateTime expiry = await getExpiry();
      if (expiry.isBefore(DateTime.now())) {
        await refreshAuth();
        _authDetails = await getSavedAuth();
      } else {
        _authDetails = await getSavedAuth();
      }
      extraHeaders ??= {};
      var sentHeaders = mergeDefaultHeader
          ? {
              ...BaseService.headers,
              ...extraHeaders,
              "Authorization": "Bearer ${_authDetails['access_token']}"
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

  static Future signIn(String email, String password, String displayName,
      bool returningUser, context) async {
    try {
      http.Response response = await BaseService.makeUnauthenticatedRequest(
          "${BaseService.BASE_URL}auth/login",
          method: "POST",
          body: json.encode({"email": email, "password": password}));
      var responseMap = json.decode(response.body);
      if (response.statusCode == 200) {
        _saveToken(responseMap["data"]["access_token"],
            responseMap["data"]["refresh_token"]);
        if (returningUser) {
          showToast(context, "Welcome Back $displayName", "success");
        } else {
          showToast(context, "Welcome $displayName to our app", "success");
        }
        await fetchAndSaveUser(context, email);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LandingScreen(),
          ),
        );
      } else {
        showToast(context, responseMap["errors"][0]["message"], "error");
        await GoogleSignIn().signOut();
      }
      return responseMap;
    } catch (err) {
      rethrow;
    }
  }

  static Future logout(context) async {
    try {
      // http.Response response = await BaseService.makeUnauthenticatedRequest(
      //     "${BaseService.BASE_URL}auth/logout",
      //     method: "POST",
      //     body: json.encode({"refresh_token": _authDetails['refresh_token']}));
      // if (response.statusCode == 200) {
      await GoogleSignIn().signOut();
      await clearAuth();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const IntroScreen1(),
        ),
      );
      showToast(context, "See you soon", "success");
      // } else {
      //   throw Exception("Something went wrong");
      // }
    } catch (err) {
      rethrow;
    }
  }

  static _saveToken(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        authNamespace,
        json.encode({
          "access_token": accessToken,
          "refresh_token": refreshToken,
        }));
    await prefs.setString(expiryNamespace,
        DateTime.now().add(const Duration(minutes: 14)).toString());
  }

  static clearAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _authDetails = {};
  }

  static Future signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      showToast(context, "Google Authentication Failed!", "error");
    } else {
      bool isUserPresent = await AuthService.isUserPresent(googleUser.email);
      if (isUserPresent) {
        await AuthService.signIn(googleUser.email, googleUser.id,
            googleUser.displayName ?? googleUser.email, true, context);
      } else {
        await AuthService.signUp(
            googleUser.email,
            googleUser.id,
            googleUser.photoUrl ?? "",
            (googleUser.displayName ?? googleUser.email.split("@").first)
                .split(" ")
                .first,
            (googleUser.displayName ?? googleUser.email.split("@").first)
                .split(" ")
                .last,
            context);
      }
    }
  }

  static Future<bool> isUserPresent(String email) async {
    try {
      http.Response response = await BaseService.makeUnauthenticatedRequest(
          "${BaseService.BASE_URL}users?filter[email][_eq]=$email",
          method: "GET");
      if (response.statusCode == 200) {
        var responseMap = json.decode(response.body);
        return responseMap["data"].length > 0 ? true : false;
      } else {
        print("Something went wrong");
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> fetchAndSaveUser(context, email) async {
    http.Response response = await BaseService.makeUnauthenticatedRequest(
        "${BaseService.BASE_URL}users?filter[email][_eq]=$email",
        method: "GET");
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseMap["data"].length > 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          userNamespace,
          json.encode(
            responseMap["data"][0],
          ),
        );
        showToast(context, "User data saved!", "info");
      }
    } else {
      print("Something went wrong");
      await logout(context);
    }
  }

  static Future signUp(String email, String password, String photoUrl,
      String firstName, String lastName, context) async {
    try {
      http.Response response = await BaseService.makeUnauthenticatedRequest(
          "${BaseService.BASE_URL}users",
          method: "POST",
          body: json.encode({
            "email": email,
            "password": password,
            "photo_url": photoUrl,
            "role": "1b0c1598-d578-48fa-9804-f0f58c172ce3",
            "first_name": firstName,
            "last_name": lastName
          }));
      var responseMap = json.decode(response.body);
      if (response.statusCode == 200) {
        await signIn(email, password, firstName, false, context);
      } else {
        showToast(context, responseMap["errors"][0]["message"], "error");
        await GoogleSignIn().signOut();
      }
    } catch (err) {
      rethrow;
    }
  }
}
