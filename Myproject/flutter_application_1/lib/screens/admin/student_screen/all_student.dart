import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  final String title = " ";
  final String score = " ";

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  List student = List.empty();
  String title = "";
  String score = "";
  @override
  void initState() {
    super.initState();
    student = ["Hello", "Hey There"];
  }

  createStudent() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("students").doc(title);

    Map<String, String> StudentList = {
      "studentTitle": title,
      "score": score,
    };

    documentReference
        .set(StudentList)
        .whenComplete(() => print("Student succesvol gemaakt"));
  }

  deleteStudent(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("students").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("Student succesvol verwijdert"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("students").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Er is iets mis gegaan');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text((documentSnapshot != null)
                              ? (documentSnapshot["studentTitle"])
                              : ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                deleteStudent((documentSnapshot != null)
                                    ? (documentSnapshot["studentTitle"])
                                    : "");
                              });
                            },
                          ),
                        ),
                      ));
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
                  content: Container(
                    width: 400,
                    height: 100,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (String value) {
                            title = value;
                            score = "0";
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            createStudent();
                          });
                          Navigator.of(context).pop();
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
