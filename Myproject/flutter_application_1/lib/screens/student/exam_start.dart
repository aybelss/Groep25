import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'exam/exam.dart';

class ExamStart extends StatefulWidget {
  final DocumentSnapshot post;
  ExamStart({required this.post});
  @override
  State<ExamStart> createState() => _ExamStartState();
}

class _ExamStartState extends State<ExamStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(//change your color here
              ),
          title: const Text("Examen", style: TextStyle()),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 150),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Student: " + widget.post['studentTitle'],
                              style: const TextStyle(fontSize: 40),
                            ),
                          ]),
                      const SizedBox(height: 100),
                      Card(
                        color: const Color.fromARGB(255, 178, 0, 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Exam(
                                    post: widget.post,
                                  ),
                                ));
                          },
                          splashColor: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(
                                  Icons.check,
                                  size: 70.0,
                                  color: Colors.white,
                                ),
                                Text("Start Examen",
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
