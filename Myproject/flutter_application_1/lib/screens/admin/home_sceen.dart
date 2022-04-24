import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/exam_screen/exam_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              color: const Color.fromARGB(255, 178, 0, 13),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExamScreen()),
                  );
                },
                splashColor: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        Icons.school,
                        size: 70.0,
                        color: Colors.white,
                      ),
                      Text("Docent",
                          style: TextStyle(fontSize: 30.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              color: const Color.fromARGB(255, 178, 0, 13),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.person_add_alt_1,
                          size: 70.0, color: Colors.white),
                      Text("Studenten",
                          style: TextStyle(fontSize: 30.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              color: const Color.fromARGB(255, 178, 0, 13),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.add_to_drive, size: 70.0, color: Colors.white),
                      Text("Firebase Backup",
                          style: TextStyle(fontSize: 30.0, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ActionChip(
              label: const Text(
                "Log uit",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                logout(context);
              },
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      )),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
