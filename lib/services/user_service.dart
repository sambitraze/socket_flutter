import 'dart:convert';

import 'package:socket_flutter/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:socket_flutter/services/auth_service.dart';
import 'package:socket_flutter/services/base_service.dart';

class UserService {
  static Future<List<User>> getAllUsers() async {
    final currentUser = await AuthService.getSavedUser();
    final response = await AuthService.makeAuthenticatedRequest(
        "${BaseService.BASE_URL}users?filter[id][_neq]=${currentUser["id"]}",
        method: "GET");
    if (response.statusCode == 200) {
      var usersJson = jsonDecode(response.body);

      return List<User>.from(
          usersJson["data"].map((use) => User.fromJson(use)));
    } else {
      return [];
    }
  }
}
