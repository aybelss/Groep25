import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'answer.dart';
import 'location.dart';

class StudentDetails extends StatefulWidget {
  final DocumentSnapshot post;
  // ignore: use_key_in_widget_constructors
  const StudentDetails({required this.post});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  String input = "";
  navigateToLocate(BuildContext context, DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            post: post,
          ),
        ));
  }

  navigateToAnswer(BuildContext context, DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerWindow(
            post: post,
          ),
        ));
  }

  hasCheated() {
    if (widget.post['hasCheated'] == "") {
      return const Text("De student heeft zijn examen nog niet gemaakt.",
          style: TextStyle(fontSize: 35));
    } else {
      return Text(
        'De student heeft ' +
            widget.post['hasCheated'].toString() +
            ' keer gespiekt.',
        style: const TextStyle(fontSize: 35),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            SizedBox(
              height: 100,
              child: Text(
                'Student: ' + widget.post['studentId'],
                style:
                    const TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 24,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (String value) {
                      input = value;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: widget.post['score'].toString(),
                      labelStyle: widget.post['score'] < 5
                          ? const TextStyle(color: Colors.red)
                          : const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                const Text(' /10', style: TextStyle(fontSize: 40)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            hasCheated(),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 178, 0, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: InkWell(
                    onTap: () {
                      int val = int.parse(input);

                      if (val > 10) {
                        widget.post.reference.update({'score': 10});
                        Navigator.pop(context);
                      } else {
                        widget.post.reference.update({'score': val});
                        Navigator.pop(context);
                      }
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.edit,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          Text("        Wijzig        ",
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(50)),
                Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 178, 0, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: InkWell(
                    onTap: () {
                      navigateToLocate(context, widget.post);
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.map,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          Text("       Locatie       ",
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(50)),
                Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 178, 0, 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: InkWell(
                    onTap: () {
                      navigateToAnswer(context, widget.post);
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.message,
                            size: 40.0,
                            color: Colors.white,
                          ),
                          Text("    Antwoorden    ",
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
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
