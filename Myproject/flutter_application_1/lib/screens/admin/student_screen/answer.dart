import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnswerWindow extends StatefulWidget {
  final DocumentSnapshot post;
  // ignore: use_key_in_widget_constructors
  const AnswerWindow({required this.post});

  @override
  State<AnswerWindow> createState() => _AnswerWindowState();
}

class _AnswerWindowState extends State<AnswerWindow> {
  List<Widget> makeListWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return snapshot.data!.docs.map((document) {
      return ListTile(
        title: Text(document['studentAnswers'].toString()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Antwoorden"),
      ),
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
                  child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: FirebaseFirestore.instance
                        .collection("adminStudent")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ListView(
                        children: makeListWidget(snapshot),
                      );
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
