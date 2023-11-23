import 'package:flutter/cupertino.dart';
import 'package:products_kart/login/model/login_model.dart';
import 'package:products_kart/login/model/login_request_model.dart';
import 'package:products_kart/login/service/login_api_service.dart';
import 'package:products_kart/product/sevice/shared_preferences_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthService authService;

  AuthProvider(this.authService);

  User? user;

  Future<bool> doLogin(LoginRequest request) async {
    try {
      notifyListeners();
      User user = await authService.doLogin(request);
      notifyListeners();
      await SharedPrefService.setLoginUser(user);
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  Future loadUser() async {
    user = await SharedPrefService.getLoginUser();
    notifyListeners();
  }
}
