import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OpenQuestion extends StatefulWidget {
  const OpenQuestion({Key? key}) : super(key: key);

  @override
  State<OpenQuestion> createState() => _OpenQuestionState();
}

class _OpenQuestionState extends State<OpenQuestion> {
  List openQuestion = List.empty();
  String question = " ";
  String answer = " ";

  createOpenQuestion(String question) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("exams").doc(question);

    Map<String, String> openQuestionList = {
      "question": question,
      "input": "",
      "type": "openquestion"
    };

    documentReference
        .set(openQuestionList)
        // ignore: avoid_print
        .whenComplete(() => print("Vraag succesvol gemaakt"));
  }

  deleteOpenQuestion(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("exams").doc(item);

    documentReference
        .delete()
        // ignore: avoid_print
        .whenComplete(() => print("Vraag succesvol verwijdert"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Open Vraag"),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Vraag"),
                onChanged: (val) {
                  question = val;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Voer een vraag in';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Antwoord"),
                onChanged: (val) {
                  answer = val;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Voer een antwoord in';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 295,
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: Card(
                  color: const Color.fromARGB(255, 178, 0, 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        createOpenQuestion(question);
                      });
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text("Indienen",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
