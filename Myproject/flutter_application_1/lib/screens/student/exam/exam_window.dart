import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamWindow extends StatefulWidget {
  final DocumentSnapshot post;
  ExamWindow({required this.post});

  @override
  State<ExamWindow> createState() => _ExamWindowState();
}

class _ExamWindowState extends State<ExamWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post['studentTitle']),
      ),
    );
  }
}
