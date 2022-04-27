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

  createStudent(String title) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("students").doc(title);

    Map<String, dynamic> StudentList = {"studentTitle": title, 'score': score};

    documentReference
        .set(StudentList)
        // ignore: avoid_print
        .whenComplete(() => print("Student succesvol gemaakt"));
  }

  deleteStudent(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("students").doc(item);

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Er is iets mis gegaan');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot<Object?>? doc = snapshot.data?.docs[index];
                  return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((documentSnapshot) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text(documentSnapshot["studentTitle"]),
                            onTap: () =>
                                navigateToDetail(context, documentSnapshot),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  deleteStudent(
                                      documentSnapshot["studentTitle"]);
                                });
                              },
                            ),
                          ),
                        );
                      }).toList());
                });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Voeg student toe"),
                  content: SizedBox(
                    width: 400,
                    height: 100,
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            hintText: "CSV",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 40),
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
    );
  }
}