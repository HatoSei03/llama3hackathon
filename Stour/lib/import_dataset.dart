import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String jsonString = await rootBundle.loadString('assets/data.json');
  List<dynamic> jsonData = json.decode(jsonString);

  // Reference to the Firestore collection
  CollectionReference places = FirebaseFirestore.instance.collection('place');

  // Loop through the JSON data and add each item to Firestore
  for (var item in jsonData) {
    item.remove('_id');
    await places
        .add(item)
        .then((value) => print("Place Added"))
        .catchError((error) => print("Failed to add place: $error"));
  }
}
