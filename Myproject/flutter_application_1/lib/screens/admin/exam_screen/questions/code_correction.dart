import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CodeCorrection extends StatefulWidget {
  const CodeCorrection({Key? key, document}) : super(key: key);

  @override
  State<CodeCorrection> createState() => _CodeCorrectionState();
}

class _CodeCorrectionState extends State<CodeCorrection> {
  List openQuestion = List.empty();
  String question = " ";
  String answer = " ";
  final _keyForm = GlobalKey<FormState>();

  createCodeCorrection(String question) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("exams").doc(question);

    Map<String, String> codeCorrectionList = {
      "question": question,
      "correctAnswer": answer,
      "type": "codecorrection"
    };

    documentReference
        .set(codeCorrectionList)
        // ignore: avoid_print
        .whenComplete(() => print("Vraag succesvol gemaakt"));
  }

  deleteCodeCorrection(item) {
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
        title: const Text("Code Correctie"),
      ),
      body: Form(
        key: _keyForm,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Codecorrectie"),
                  onChanged: (val) {
                    question = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Voer een vraag in';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Antwoord"),
                  onChanged: (val) {
                    answer = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Voer een antwoord in';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 260,
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
                        if (_keyForm.currentState!.validate()) {
                          setState(() {
                            createCodeCorrection(question);
                          });
                          Navigator.of(context).pop();
                        }
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
      ),
    );
  }
}
