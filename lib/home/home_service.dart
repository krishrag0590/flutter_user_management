import 'dart:convert';

import 'package:dio/dio.dart';

import 'home_model.dart';

class HomeService {
  createUserService(userData) async {
    var res =
        await Dio().post('http://192.168.1.7:3000/create', data: userData);
    return res.data;
  }

  listUserService() async {
    var res = await Dio().get('http://192.168.1.7:3000/list');
    if (res.statusCode == 200) {
      List<Map<String, dynamic>> userList = [];
      var json = jsonDecode(res.data);
      json.forEach((a) {
        var resData = UserModel.fromJson(a);
        // print('foreach - ${resData}');
        var x = resData.toJson();
        userList.add(x);
      });

      // var result = HomeModel.fromJson(response.data['data']);
      // var res = result.toJson();
      return userList;
    }
  }

  updateUserService(userData) async {
    var res =
        await Dio().post('http://192.168.1.7:3000/update', data: userData);
    return res.data;
  }

  deleteUserService(userData) async {
    var res =
        await Dio().post('http://192.168.1.7:3000/delete', data: userData);
    return res.data;
  }
}
