import 'dart:convert';

import 'package:products_kart/login/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static Future<void> saveUser(User user) async {
    final userDetails = jsonEncode(user.toJson());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userDetails", userDetails);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString("userDetails");
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr));
    }
    return null;
  }
}
