import 'package:aug_30_test/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Users extends ConsumerWidget {
  Users({Key? key}) : super(key: key);

  int userCount = 10;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usersList = ref.watch(usersControllers).usersList;
    userCount = usersList.length;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                onPressed: () {
                  _addUserDialog(context, ref);
                }),
            title: const Text(
              'Users',
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false);
                  },
                  icon: const Icon(Icons.exit_to_app))
            ]),
        body: Column(children: [
          Container(
            height: size.height * 0.05,
            width: size.width,
            color: Colors.orangeAccent,
            alignment: Alignment.center,
            child: Text(
              'No.of users : ${userCount}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.2),
              ),
              height: size.height * 0.7746,
              width: size.width,
              // color: Colors.white12,
              child: ListView.builder(
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        usersList[index]['avatar'],
                        height: 40,
                        width: 40,
                      ),
                    ),
                    title: Text(usersList[index]['first_name']),
                    trailing: SizedBox(
                      width: 145,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'profile', (route) => false,
                                  arguments: {
                                    'id': usersList[index]['id'],
                                    'email': usersList[index]['email'],
                                    'first_name': usersList[index]
                                        ['first_name'],
                                    'last_name': usersList[index]['last_name'],
                                    'avatar': usersList[index]['avatar']
                                  });
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_rounded,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ))
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: size.height * 0.05,
            width: size.width,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const Text(
              'copyrights',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]),
      ),
    );
  }
}

Future<void> _addUserDialog(BuildContext context, WidgetRef ref) async {
  // var usersListData = ref.watch(homeController).usersListData;
  final TextEditingController name = TextEditingController();
  final TextEditingController job = TextEditingController();
  var res = ref.watch(usersControllers).createUserListRes;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add user'),
          backgroundColor: Colors.white,
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter your Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: job,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Job',
                          hintText: 'Enter your Job'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('OK'),
              onPressed: () async {
                Map userData = {"name": name.text, "job": job.text};
                await ref.read(usersControllers).createUserController(userData);
                print('res');
                // if (res[0]['Message'] == 'Successfully updated') {
                //   await ref.read(homeController).listUserController();
                //   Navigator.pop(context);
                //   Fluttertoast.showToast(
                //       msg: res[0]['Message'],
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.BOTTOM,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor: Colors.green,
                //       textColor: Colors.white,
                //       fontSize: 16.0);
                // } else {
                //   Fluttertoast.showToast(
                //       msg: 'Retry later',
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.BOTTOM,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor: Colors.red,
                //       textColor: Colors.white,
                //       fontSize: 16.0);
                // }
              },
            ),
          ],
        );
      });
}
