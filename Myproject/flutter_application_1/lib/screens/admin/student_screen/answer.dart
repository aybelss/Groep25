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
  final database = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Antwoorden'),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
                child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.post['openQuestionAnswers'].toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ]))));
  }
}
