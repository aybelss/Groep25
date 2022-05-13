import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/student/exam/exam_start.dart';

class StudentStart extends StatefulWidget {
  const StudentStart({Key? key}) : super(key: key);
  final title = " ";
  @override
  State<StudentStart> createState() => _StudentStartState();
}

class _StudentStartState extends State<StudentStart> {
  navigateToExam(BuildContext context, DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExamStart(
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
          if (snapshot.data == null) {
            return const Text('Er zijn geen studenten');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((documentSnapshot) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(documentSnapshot["studentTitle"]),
                      onTap: () => navigateToExam(context, documentSnapshot),
                    ),
                  );
                }).toList());
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
    );
  }
}
