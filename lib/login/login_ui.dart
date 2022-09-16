import 'package:aug_30_test/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(20),
          // color: const Color.fromARGB(160, 0, 225, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/login2.png'),
                height: 150,
                width: 150,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _password,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    ref.read(usersControllers).listUsersController();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'users', (route) => false);
                    // await ref.read(loginController).loginFunction(
                    //     {"username": _username.text, "password": _password.text});
                    // if (loginData.isNotEmpty) {
                    //   ref.read(homeController).listUserController();
                    //   Navigator.pushNamedAndRemoveUntil(
                    //       context, 'home', (route) => false);
                    // } else {
                    //   // print('Invalid login');
                    // }
                    // print(
                    //     'Username - ${_username.text}, Password - ${_password.text}');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 189, 39, 226))),
                  label: const Text('Login'),
                  icon: const Icon(
                    Icons.login,
                    size: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
