import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        title: const Text("Exam Screen"),
      ),
      backgroundColor: Colors.white,
    );
  }
}
