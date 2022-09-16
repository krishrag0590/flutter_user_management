import 'package:aug_30_test/home/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeController =
    ChangeNotifierProvider<HomeController>((ref) => HomeController());

class HomeController extends ChangeNotifier {
  final List _createUserRes = [];
  List _usersListData = [];
  final List _updateUserRes = [];
  final List _deleteUserRes = [];
  createUserController(userData) async {
    HomeService homeService = HomeService();
    var res = await homeService.createUserService(userData);
    _createUserRes.add(res);
    notifyListeners();
  }

  listUserController() async {
    HomeService homeService = HomeService();
    var res = await homeService.listUserService();
    _usersListData = res;
    notifyListeners();
  }

  updateUserController(userData) async {
    HomeService homeService = HomeService();
    var res = await homeService.updateUserService(userData);
    _updateUserRes.add(res);
    notifyListeners();
  }

  deleteUserController(index, id) async {
    HomeService homeService = HomeService();
    _usersListData.removeAt(index);
    var req = {"id": id};
    var res = await homeService.deleteUserService(req);
    _deleteUserRes.add(res);
    notifyListeners();
  }

  List get createUserRes => _createUserRes;
  List get usersListData => _usersListData;
  List get updateUserRes => _updateUserRes;
  List get deleteUserRes => _deleteUserRes;
}
