import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: const Text("Examen"),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.add_box,
                            size: 40.0,
                          ),
                          Text("     MeerKeuze Vraag     ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(50)),
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.add_box,
                            size: 40.0,
                          ),
                          Text("          Open vraag          ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(50)),
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.add_box,
                            size: 40.0,
                          ),
                          Text("      Code correctie      ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }
}
