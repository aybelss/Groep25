import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  /*Future createUser({required String name}) async {
    final docStudent =
        FirebaseFirestore.instance.collection('students').doc('my-id');
    final json = {'id': name};
    await docStudent.set(json);
  }*/
}
