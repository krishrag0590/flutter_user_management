import 'package:aug_30_test/users/users_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersControllers =
    ChangeNotifierProvider<UsersControllers>((ref) => UsersControllers());

class UsersControllers extends ChangeNotifier {
  List _usersList = [];
  Map _createUserListRes = {};

  listUsersController() async {
    UsersService usersService = UsersService();
    var res = await usersService.getUsersList();
    _usersList = res;
    notifyListeners();
  }

  createUserController(userData) async {
    UsersService usersService = UsersService();
    var res = await usersService.createUserService(userData);
    _createUserListRes = res;
    notifyListeners();
  }

  List get usersList => _usersList;
  Map get createUserListRes => _createUserListRes;
}
