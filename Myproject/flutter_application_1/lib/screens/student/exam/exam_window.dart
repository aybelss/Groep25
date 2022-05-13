// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'exam_start.dart';

class ExamWindow extends StatefulWidget {
  final DocumentSnapshot postStudent;
  final DocumentSnapshot postExam;
  // ignore: use_key_in_widget_constructors
  const ExamWindow({required this.postExam, required this.postStudent});

  @override
  State<ExamWindow> createState() => _ExamWindowState();
}

class _ExamWindowState extends State<ExamWindow> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // dit zorgt ervoor dat de app kan zien wanneer de student de app verlaat en telt het op
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      return;
    }
    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      counter++;
    }
  }

  String answer = "";

  final TextEditingController _textEditingController = TextEditingController();

  //hier worden de openvragen opgehaald en opgeslagen in de database en later weergegeven in de antwoorden window
  Future<void> createOpenAnswer(String studentId, String question,
      String answer, String questionID) async {
    CollectionReference students = FirebaseFirestore.instance
        .collection('adminStudent')
        .doc(studentId)
        .collection('openQuestionAnswers');
    return await students.doc(questionID).set(
      {
        'question': question,
        'answer': answer,
        'questionID': questionID,
      },
    );
  }

  //hier worden de multiplevragen en de codecorrectievragen opgehaald en opgeslagen in de database
  Future<void> createAnswer(
      String studentId, String question, String answer) async {
    CollectionReference students =
        FirebaseFirestore.instance.collection('adminStudent');

    if (answer == widget.postExam['correctAnswer']) {
      return await students.doc(studentId).set({
        'studentAnswers': {
          question: {'answer': answer, 'score': 2}
        }
      }, SetOptions(merge: true));
    } else if (answer != widget.postExam['correctAnswer']) {
      return await students.doc(studentId).set({
        'studentAnswers': {
          question: {'answer': answer, 'score': 0}
        }
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.postStudent['studentTitle']),
        ),
        body: Center(
          child: widget.postExam['type'] == 'multiplechoice'
              ? Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          'MeerKeuze Vraag',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 80),
                        Text(
                          widget.postExam['question'],
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 50),
                        //options with radio buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: widget.postExam['option1'] as String,
                              groupValue: answer,
                              onChanged: (value) {
                                setState(() {
                                  answer = value!;
                                });
                              },
                            ),
                            Text(
                              widget.postExam['option1'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: widget.postExam['option2'] as String,
                              groupValue: answer,
                              onChanged: (value) {
                                setState(() {
                                  answer = value!;
                                });
                              },
                            ),
                            Text(
                              widget.postExam['option2'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: widget.postExam['option3'] as String,
                              groupValue: answer,
                              onChanged: (value) {
                                setState(() {
                                  answer = value!;
                                });
                              },
                            ),
                            Text(
                              widget.postExam['option3'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 400,
                          child: Card(
                            color: const Color.fromARGB(255, 178, 0, 13),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: InkWell(
                              onTap: () {
                                createAnswer(
                                  widget.postStudent['studentTitle'],
                                  widget.postExam['question'],
                                  answer,
                                );
                                Navigator.of(context)
                                    .pop(_textEditingController.text);
                              },
                              splashColor: Colors.black,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.save_as_outlined,
                                      size: 70.0,
                                      color: Colors.white,
                                    ),
                                    Text("Sla op",
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              : widget.postExam['type'] == 'openquestion'
                  ? Padding(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              'Open Vraag',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 80),
                            Text(
                              widget.postExam['question'],
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 50),
                            TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: 'Antwoord',
                                hintText: 'Antwoord',
                              ),
                              onChanged: (String value2) {
                                answer = value2;
                              },
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              width: 400,
                              child: Card(
                                color: const Color.fromARGB(255, 178, 0, 13),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: InkWell(
                                  onTap: () {
                                    createOpenAnswer(
                                        widget.postStudent['studentTitle'],
                                        widget.postExam['question'],
                                        answer,
                                        questionID.toString());
                                    questionID++;
                                    Navigator.of(context)
                                        .pop(_textEditingController.text);
                                  },
                                  splashColor: Colors.black,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.save_as_outlined,
                                          size: 70.0,
                                          color: Colors.white,
                                        ),
                                        Text("Sla op",
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  : widget.postExam['type'] == 'codecorrection'
                      ? Padding(
                          padding: const EdgeInsets.all(30),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'Code Correctie',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 100),
                                Text(widget.postExam['question'],
                                    style: const TextStyle(fontSize: 30)),
                                const SizedBox(height: 50),
                                TextField(
                                  controller: _textEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Antwoord',
                                  ),
                                  onChanged: (String value3) {
                                    answer = value3;
                                  },
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width: 400,
                                  child: Card(
                                    color:
                                        const Color.fromARGB(255, 178, 0, 13),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: InkWell(
                                      onTap: () {
                                        createAnswer(
                                          widget.postStudent['studentTitle'],
                                          widget.postExam['question'],
                                          answer,
                                        );
                                        Navigator.of(context)
                                            .pop(_textEditingController.text);
                                      },
                                      splashColor: Colors.black,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                            Icon(
                                              Icons.save_as_outlined,
                                              size: 70.0,
                                              color: Colors.white,
                                            ),
                                            Text("Sla op",
                                                style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      : const Text('Er is iets mis gegaan'),
        ));
  }
}
