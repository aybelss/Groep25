import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  final DocumentSnapshot post;
  // ignore: use_key_in_widget_constructors
  const LocationScreen({required this.post});

  @override
  State<LocationScreen> createState() => _LocationScreen();
}

class _LocationScreen extends State<LocationScreen> {
  String realAddress = "";

  getAddress() async {
    http.Response response = await http.get(Uri.parse(
        "http://nominatim.openstreetmap.org/reverse?format=json&lat=" +
            widget.post['lat'].toString() +
            "&lon=" +
            widget.post['long'].toString() +
            "&zoom=18&addressdetails="));
    var values = json.decode(response.body);
    String address = values['display_name'];

    realAddress = address;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Location'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (widget.post["lat"] != "")
              SizedBox(
                height: 700,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(widget.post["lat"], widget.post["long"]),
                    minZoom: 18.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(markers: [
                      Marker(
                          width: 45.0,
                          height: 45.0,
                          point:
                              LatLng(widget.post["lat"], widget.post["long"]),
                          builder: (context) => IconButton(
                                icon: const Icon(Icons.location_on),
                                color: Colors.red,
                                iconSize: 45.0,
                                onPressed: () {},
                              ))
                    ])
                  ],
                ),
              ),
            getAddress() == ""
                ? const Text("Loading...")
                : Text(
                    realAddress,
                    style: const TextStyle(fontSize: 20),
                  ),
          ]),
        ));
  }
}
