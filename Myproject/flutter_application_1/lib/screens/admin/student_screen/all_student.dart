import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/student_screen/student_details.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  final String title = " ";
  final int score = 0;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  List student = List.empty();
  String title = "";
  int score = 0;

  @override
  void initState() {
    super.initState();
    student = ["Hello", "Hey There"];
  }

  createStudentAdmin(String title) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("adminStudent").doc(title);

    Map<String, dynamic> studentList = {
      "studentId": title,
      'score': score,
      "lat": "",
      "long": "",
      "hasCheated": ""
    };

    documentReference
        .set(studentList)
        // ignore: avoid_print
        .whenComplete(() => print("Student succesvol gemaakt"));
  }

  createStudent(String title) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("students").doc(title);

    Map<String, dynamic> studentList = {"studentTitle": title};

    documentReference
        .set(studentList)
        // ignore: avoid_print
        .whenComplete(() => print("Student succesvol gemaakt"));
  }

  deleteStudent(id) {
    for (var i = 0; i < 15; i++) {
      var documentReference1 = FirebaseFirestore.instance
          .collection("adminStudent")
          .doc(id)
          .collection('openQuestionAnswers');

      documentReference1.doc(i.toString()).delete();
    }
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("adminStudent").doc(id);
    documentReference
        .delete()
        // ignore: avoid_print
        .whenComplete(() => print("Student succesvol verwijdert"));

    documentReference =
        FirebaseFirestore.instance.collection("students").doc(id);
    documentReference
        .delete()
        // ignore: avoid_print
        .whenComplete(() => print("Student succesvol verwijdert"));
  }

  navigateToDetail(BuildContext context, DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDetails(
            post: post,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Studenten"),
        ),
        body: Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            SizedBox(
              height: 650,
              width: 1500,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("adminStudent")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Text('Er zijn geen studenten');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return SingleChildScrollView(
                      child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((documentSnapshot) {
                            return Card(
                              elevation: 4,
                              child: ListTile(
                                title: Text(documentSnapshot["studentId"]),
                                onTap: () {
                                  navigateToDetail(context, documentSnapshot);
                                },
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: const Color.fromARGB(255, 178, 0, 13),
                                  onPressed: () {
                                    setState(() {
                                      deleteStudent(
                                          documentSnapshot["studentId"]);
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 178, 0, 13),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: const Text("Voeg student toe"),
                        content: SingleChildScrollView(
                          child: SizedBox(
                            width: 400,
                            height: 200,
                            child: Column(
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "CSV",
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 80),
                                  ),
                                  onChanged: (String value) {
                                    title = value;
                                    score = 0;
                                  },
                                  maxLines: 7,
                                  minLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                // ignore: non_constant_identifier_names
                                List<String> StudentIds = title.split(';');
                                // ignore: unnecessary_null_comparison
                                if (title.split(';') == null) {
                                  StudentIds = [title];
                                }
                                if (title != '') {
                                  Navigator.of(context).pop();
                                  for (int i = 0; i < title.length; i++) {
                                    createStudentAdmin(StudentIds[i]);
                                    createStudent(StudentIds[i]);
                                  }
                                } else {
                                  // ignore: avoid_print
                                  print('No student IDs entered');
                                }
                              },
                              child: const Text("Voeg toe"))
                        ],
                      );
                    });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ]),
        )));
  }
}
