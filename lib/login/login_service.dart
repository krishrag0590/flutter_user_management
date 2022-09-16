import 'package:dio/dio.dart';

class LoginService {
  validateLogin(userData) async {
    var res = await Dio().post('http://192.168.1.7:3000/login', data: userData);
    if (res.statusCode == 200) {
      return res.data;
    }
  }
}
