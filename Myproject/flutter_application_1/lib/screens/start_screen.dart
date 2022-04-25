import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/student/student_start_screen.dart';

import 'admin/home/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          splashColor: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(
                                  Icons.admin_panel_settings,
                                  size: 70.0,
                                  color: Colors.white,
                                ),
                                Text("Admin",
                                    style: TextStyle(
                                        fontSize: 30.0, color: Colors.white))
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StudentStart()),
                            );
                          },
                          splashColor: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(
                                  Icons.person,
                                  size: 70.0,
                                  color: Colors.white,
                                ),
                                Text("Student",
                                    style: TextStyle(
                                        fontSize: 30.0, color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }
}
