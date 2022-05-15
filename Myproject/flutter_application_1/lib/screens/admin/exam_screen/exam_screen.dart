import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/exam_screen/questions/code_correction.dart';
import 'package:flutter_application_1/screens/admin/exam_screen/questions/multiple_choice.dart';
import 'package:flutter_application_1/screens/admin/exam_screen/questions/open_question.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  List<Widget> makeListQuestion(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return snapshot.data!.docs.map<Widget>((document) {
      return ListTile(
        title: Text(document["question"], style: const TextStyle(fontSize: 18)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: const Color.fromARGB(255, 178, 0, 13),
          onPressed: () {
            setState(() {
              deleteQuestion(document["question"]);
            });
          },
        ),
      );
    }).toList();
  }

  deleteQuestion(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("exams").doc(item);

    documentReference
        .delete()
        // ignore: avoid_print
        .whenComplete(() => print("Vraag succesvol verwijdert"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: const Text("Examen"),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(
                        "exams",
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView(
                      children: makeListQuestion(snapshot),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MultipleChoice()));
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.add_box,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            Text("     MeerKeuze Vraag     ",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OpenQuestion()));
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.add_box,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            Text("          Open vraag          ",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CodeCorrection()));
                      },
                      splashColor: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(
                              Icons.add_box,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            Text("      Code correctie      ",
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
            ]),
      )),
    );
  }
}
