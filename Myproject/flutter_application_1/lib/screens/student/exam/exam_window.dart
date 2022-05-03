import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamWindow extends StatefulWidget {
  final DocumentSnapshot postStudent;
  final DocumentSnapshot postExam;
  ExamWindow({required this.postExam, required this.postStudent});

  @override
  State<ExamWindow> createState() => _ExamWindowState();
}

MultipleChoice() {}

OpenQuestion() {
  //code
}
CodeCorrection() {
  //code
}

class _ExamWindowState extends State<ExamWindow> {
  String answer = "";
  createOpenQuestion(String question) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("exams").doc(question);

    Map<String, String> openQuestionList = {
      "question": question,
      "input": answer,
      "type": "openquestion",
    };
    documentReference
        .set(openQuestionList)
        // ignore: avoid_print
        .whenComplete(() => print("Vraag succesvol gemaakt"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.postStudent['studentTitle']),
        ),
        body: Center(
          child: widget.postExam['type'] == 'multiplechoice'
              ? Text('multipleChoice')
              : widget.postExam['type'] == 'openquestion'
                  ? Padding(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Open Vraag',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 80),
                            Text(
                              widget.postExam['question'],
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(height: 50),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Antwoord',
                              ),
                              onChanged: (String value) {
                                answer = value;
                              },
                            ),
                            SizedBox(height: 50),
                            SizedBox(
                              width: 400,
                              child: Card(
                                color: const Color.fromARGB(255, 178, 0, 13),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: InkWell(
                                  onTap: () {
                                    createOpenQuestion(
                                        widget.postExam['question']);
                                    Navigator.pop(context);
                                  },
                                  splashColor: Colors.black,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.save_as_outlined,
                                          size: 70.0,
                                          color: Colors.white,
                                        ),
                                        Text("Sla op",
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  : widget.postExam['type'] == 'codecorrection'
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'Code Correctie',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 100),
                                Text(widget.postExam['question'],
                                    style: TextStyle(fontSize: 30)),
                                SizedBox(height: 50),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Antwoord',
                                  ),
                                ),
                                SizedBox(height: 50),
                                SizedBox(
                                  width: 400,
                                  child: Card(
                                    color:
                                        const Color.fromARGB(255, 178, 0, 13),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor: Colors.black,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                            Icon(
                                              Icons.save_as_outlined,
                                              size: 70.0,
                                              color: Colors.white,
                                            ),
                                            Text("Sla op",
                                                style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      : const Text('Er is iets mis gegaan'),
        ));
  }
}
