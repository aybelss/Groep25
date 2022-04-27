/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

Future getPosts() async {
  var firestore = FirebaseFirestore.instance;
  QuerySnapshot response =
      await FirebaseFirestore.instance.collection("posts").get();
  return response.docs;
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading ..."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data[index].data()['title']),
                      ),
                    );  
                  });
            }
          }),
    );
  }
}
*/