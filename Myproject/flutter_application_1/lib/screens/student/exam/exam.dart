import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../student_start_screen.dart';
import 'exam_window.dart';

class Exam extends StatefulWidget {
  final DocumentSnapshot post;
  Exam({required this.post});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  navigateToDetail(BuildContext context, DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExamWindow(
            post: post,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post['studentTitle']),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("exams").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Er is iets mis gegaan');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((documentSnapshot) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(documentSnapshot["question"]),
                      onTap: () => navigateToDetail(context, documentSnapshot),
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
      //button that finishes the exam
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentStart(),
              ));
        },
        child: Text('Finish'),
      ),
    );
  }
}
