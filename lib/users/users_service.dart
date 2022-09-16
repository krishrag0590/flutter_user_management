import 'dart:convert';

import 'package:aug_30_test/home/home_model.dart';
import 'package:dio/dio.dart';

class UsersService {
  getUsersList() async {
    var res = await Dio().get('https://reqres.in/api/users?page=2');
    if (res.statusCode == 200) {
      return res.data['data'];
    }
  }

  createUserService(userData) async {
    Response res =
        await Dio().post('https://reqres.in/api/users', data: userData);
    print(res);
    // var json = jsonDecode(res.data);
    // var a = UserModel.fromJson(res);
    // print(a);
    return res;
  }
}
