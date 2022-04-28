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
            Container(
              height: 500,
              width: 1100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: ListView(),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
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
