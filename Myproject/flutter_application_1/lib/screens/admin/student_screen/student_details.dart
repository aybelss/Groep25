import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  final DocumentSnapshot post;
  StudentDetails({required this.post});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  String input = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.post['studentTitle'] + ': ',
                  style: const TextStyle(fontSize: 40),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.width * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 24,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (String value) {
                      input = value;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: widget.post['score'].toString(),
                      labelStyle: widget.post['score'] < 10
                          ? const TextStyle(color: Colors.red)
                          : const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                const Text(' /20', style: TextStyle(fontSize: 40)),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {
                      int val = int.parse(input);

                      if (val > 20) {
                        widget.post.reference.update({'score': 20});
                        Navigator.pop(context);
                      } else {
                        widget.post.reference.update({'score': val});
                        Navigator.pop(context);
                      }
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.edit,
                            size: 40.0,
                          ),
                          Text("        Wijzig        ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(50)),
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.map,
                            size: 40.0,
                          ),
                          Text("          GPS           ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(50)),
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.message,
                            size: 40.0,
                          ),
                          Text("    Antwoorden     ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(50)),
                Card(
                  color: Colors.grey,
                  child: InkWell(
                    onTap: () {
                      widget.post.reference.delete();
                      Navigator.pop(context);
                    },
                    splashColor: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Icon(
                            Icons.delete,
                            size: 40.0,
                          ),
                          Text("     Verwijder      ",
                              style: TextStyle(
                                fontSize: 30.0,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }
}
