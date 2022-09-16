import 'package:aug_30_test/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var usersListData = ref.watch(homeController).usersListData;
    var res = ref.watch(homeController).deleteUserRes;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User list'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        leading: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(homeController).listUserController();
            }),
        actions: [
          IconButton(
              onPressed: () {
                _displayTextInputDialog(context, ref);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.blueAccent,
            child: const Text(
              'Header',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 412,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: usersListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: Colors.yellow,
                      title: Text(usersListData[index]['name']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                _editUserDialog(context, ref, index);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .read(homeController)
                                    .deleteUserController(index.toInt(),
                                        usersListData[index]['id']);
                                if (res[0]['Message'] ==
                                    'Successfully updated') {
                                  await ref
                                      .read(homeController)
                                      .listUserController();
                                  Fluttertoast.showToast(
                                      msg: res[0]['Message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              icon: const Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.pink,
            child: const Text(
              'Footer',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    ));
  }
}

Future<void> _displayTextInputDialog(
    BuildContext context, WidgetRef ref) async {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  var res = ref.watch(homeController).createUserRes;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New'),
          backgroundColor: Colors.tealAccent,
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
            child: SingleChildScrollView(
              child: Column(
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
                      controller: age,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age',
                          hintText: 'Enter your age'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 255, 0, 0))),
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text('OK'),
              onPressed: () async {
                var userData = {"name": name.text, "age": age.text};
                await ref.read(homeController).createUserController(userData);
                if (res[0]['Message'] == 'Successfully saved') {
                  await ref.read(homeController).listUserController();
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: res[0]['Message'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Retry later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ],
        );
      });
}

Future<void> _editUserDialog(
    BuildContext context, WidgetRef ref, int id) async {
  var usersListData = ref.watch(homeController).usersListData;
  final TextEditingController name =
      TextEditingController(text: usersListData[id]['name']);
  final TextEditingController age =
      TextEditingController(text: usersListData[id]['age']);
  var res = ref.watch(homeController).updateUserRes;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit'),
          backgroundColor: Colors.blueAccent,
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
                      controller: age,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age',
                          hintText: 'Enter your age'),
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
                var userData = {
                  "id": usersListData[id]['id'],
                  "name": name.text,
                  "age": age.text
                };
                await ref.read(homeController).updateUserController(userData);
                if (res[0]['Message'] == 'Successfully updated') {
                  await ref.read(homeController).listUserController();
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: res[0]['Message'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Retry later',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ],
        );
      });
}
