import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({Key? key}) : super(key: key);

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  List multiplechoice = List.empty();
  String question = " ";
  String option1 = " ";
  String option2 = " ";
  String option3 = " ";
  String correctAnswer = " ";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  createMultipleChoice(String question) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("exams").doc(question);

    Map<String, String> multipleChoiceList = {
      "question": question,
      "option1": option1,
      "option2": option2,
      "option3": option3,
      "correctAnswer": correctAnswer,
      "type": "multiplechoice"
    };

    documentReference
        .set(multipleChoiceList)
        // ignore: avoid_print
        .whenComplete(() => print("Vraag succesvol gemaakt"));
  }

  deleteMultipleChoice(item) {
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
        title: const Text("Meerkeuze Vraag"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Vraag"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Voer een vraag in';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    question = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Optie een"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Voer een optie in';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    option1 = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Optie twee"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Voer een optie in';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    option2 = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Optie drie"),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Voer een vraag in';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    option3 = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Juiste Antwoord"),
                  onChanged: (val) {
                    correctAnswer = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Voer een juiste antwoord in';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 200,
                  height: 100,
                  child: Card(
                    elevation: 10,
                    color: const Color.fromARGB(255, 178, 0, 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            createMultipleChoice(question);
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
