import 'package:flutter/material.dart';

class OpenQuestion extends StatefulWidget {
  const OpenQuestion({Key? key}) : super(key: key);

  @override
  State<OpenQuestion> createState() => _OpenQuestionState();
}

class _OpenQuestionState extends State<OpenQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Vraag"),
      ),
    );
  }
}
