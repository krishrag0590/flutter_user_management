import 'package:aug_30_test/home/home_ui.dart';
import 'package:aug_30_test/profile/profile_ui.dart';
import 'package:aug_30_test/users/users_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login/login_ui.dart';

void main() {
  runApp(const ProviderScope(child: Main()));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: 'login',
      routes: {
        'login': (context) => Login(),
        'home': (context) => const Home(),
        'users': (context) => Users(),
        'profile': (context) => Profile(),
      },
    );
  }
}
