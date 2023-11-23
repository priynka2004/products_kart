import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:products_kart/login/model/login_model.dart';
import 'package:products_kart/login/model/login_request_model.dart';
import 'package:products_kart/util/api_endpoint.dart';

class AuthService {
  Future<User> doLogin(LoginRequest request) async {
    http.Response response = await http.post(
      Uri.parse(ApiEndPoint.login),
      body: jsonEncode(request.toJson()),
      headers: {
        'content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }

      final result = jsonDecode(response.body);
      return User.fromJson(result);
    } else {
      throw "Something went wrong";
    }
  }
}
