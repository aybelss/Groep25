import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/student_screen/all_student.dart';

class AnswerWindow extends StatefulWidget {
  final DocumentSnapshot post;
  // ignore: use_key_in_widget_constructors
  const AnswerWindow({required this.post});

  @override
  State<AnswerWindow> createState() => _AnswerWindowState();
}

class _AnswerWindowState extends State<AnswerWindow> {
  final database = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antwoorden'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: database.collection("adminStudent").snapshots(),
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
                        title:
                            Text(widget.post['openQuestionAnswers'].toString()),
                        onTap: () {},
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
    );
  }
}
