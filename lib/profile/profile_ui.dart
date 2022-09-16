import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'users', (route) => false);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.center,
            child: ClipOval(child: Image.network(args['avatar'])),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                text: 'Id   ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "  ${args['id']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange)),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                text: 'First name   ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "  ${args['first_name']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange)),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                text: 'Last name   ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "  ${args['last_name']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange)),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                text: 'Email   ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "  ${args['email']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange)),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
