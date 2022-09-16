import 'package:aug_30_test/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginController =
    ChangeNotifierProvider<LoginController>(((ref) => LoginController()));

class LoginController extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  final List _user = [];
  loginFunction(userData) async {
    var res = await _loginService.validateLogin(userData);
    _user.add(res);
    notifyListeners();
  }

  List get user => _user;
}
