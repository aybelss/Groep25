import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/start_screen.dart';
import 'exam_window.dart';
import 'exam_start.dart';

class Exam extends StatefulWidget {
  final DocumentSnapshot post;
  // ignore: use_key_in_widget_constructors
  const Exam({required this.post});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    countDown();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      return;
    }
    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      print("paused");
      counter++;
    }
  }

  navigateToDetail(BuildContext context, DocumentSnapshot studentpost,
      DocumentSnapshot exampost) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExamWindow(postStudent: studentpost, postExam: exampost),
        )).then((valueFromTextField) {
      // save the value from the textfield
    });
  }

  Future calculatePoints() async {
    String id = widget.post['studentTitle'];
    var collection = FirebaseFirestore.instance.collection('adminStudent');
    await collection.get().then((value) {
      for (var queryDocumentSnapshot in value.docs) {
        int score = 0;
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        id = queryDocumentSnapshot.id;
        var test = data['studentAnswers'];
        test.forEach((key, value) {
          score += int.parse(value['score'].toString());
        });
        collection.doc(id).update({'score': score});
      }
    });
  }

  deleteStudent(id) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("students").doc(id);

    documentReference
        .delete()
        // ignore: avoid_print
        .whenComplete(() => print("Student succesvol verwijdert"));
  }

  int t = 300;
  countDown() {
    Future.doWhile(() async {
      //this changes the value by -1 every second until it reaches zero
      await Future.delayed(
        const Duration(seconds: 1),
      );
      setState(() {
        //add text widget in your build method which takes t as the data
        t--;
      });
      if (t == 0) {
        hasCheated(counter);
        calculatePoints();
        deleteStudent(widget.post['studentTitle']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StartScreen(),
            ));
      }
      return t != 0;
    });
  }

  hasCheated(int count) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("adminStudent")
        .doc(widget.post['studentTitle']);

    Map<String, dynamic> studentList = {"hasCheated": count};
    SetOptions(merge: true);

    documentReference
        .update(studentList)
        // ignore: avoid_print
        .whenComplete(() => print("Counter succesvoll toegevoegd"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer: " + t.toString()),
        automaticallyImplyLeading: false,
        centerTitle: true,
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
                      onTap: () => navigateToDetail(
                          context, widget.post, documentSnapshot),
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
          hasCheated(counter);
          calculatePoints();
          deleteStudent(widget.post['studentTitle']);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StartScreen(),
              ));
        },
        child: const Text('Finish'),
      ),
    );
  }
}
