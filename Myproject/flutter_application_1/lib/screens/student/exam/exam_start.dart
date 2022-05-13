// ignore_for_file: use_key_in_widget_constructors, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'exam.dart';

class ExamStart extends StatefulWidget {
  final DocumentSnapshot post;
  const ExamStart({required this.post});
  @override
  State<ExamStart> createState() => _ExamStartState();
}

int questionID = 0;
int counter = 0;

class _ExamStartState extends State<ExamStart> {
  @override
  //hier zetten we de questionId en counter van de timer weer op 0
  // ignore: must_call_super
  void initState() {
    if (questionID != 0) {
      questionID = 0;
    }
    if (counter != 0) {
      counter = 0;
    }
  }

  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  late LocationData _locationData;
  // ignore: prefer_final_fields
  bool _isListening = false, _isGettingLocation = false;

//methode om de locatie te ophalen
  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    setState(() {
      _isGettingLocation = true;
    });

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("adminStudent")
        .doc(widget.post['studentTitle']);

    Map<String, dynamic> studentList = {
      "lat": _locationData.latitude,
      "long": _locationData.longitude,
    };
    SetOptions(merge: true);

    documentReference
        .update(studentList)
        // ignore: avoid_print
        .whenComplete(() => print("Location succesvoll toegevoegd"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(//change your color here
              ),
          title: const Text("Examen", style: TextStyle()),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 150),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Student: " + widget.post['studentTitle'],
                              style: const TextStyle(fontSize: 40),
                            ),
                          ]),
                      const SizedBox(height: 100),
                      Card(
                        color: const Color.fromARGB(255, 178, 0, 13),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            getLocation();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Exam(
                                    post: widget.post,
                                  ),
                                ));
                          },
                          splashColor: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(
                                  Icons.check,
                                  size: 70.0,
                                  color: Colors.white,
                                ),
                                Text("Start Examen",
                                    style: TextStyle(
                                        fontSize: 30.0, color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }
}
