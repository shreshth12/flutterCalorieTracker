import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

deleteData() async {
  final instance = FirebaseFirestore.instance;
  final batch = instance.batch();
  var collection = instance.collection('tracker');
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    batch.delete(doc.reference);
  }
  await batch.commit();
}

addDataToUser(double calculatedBMR, String uid) {
  String res = "Some error occured";
  try {
    FirebaseFirestore.instance.collection('users').doc(uid).set(
      {'BMR': calculatedBMR.round()},
      SetOptions(merge: true),
    );
    res = 'success';
  } catch (err) {
    res = err.toString();
  }

  return res;
}

freshCalorieSetter(
    var user, var calories, var carbs, var fats, var protein, var foodName) {
  String res = "Some error occured";
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  try {
    FirebaseFirestore.instance.collection('tracker').add({
      "user": user,
      "calories": calories,
      "carbs": carbs,
      "fats": fats,
      "protein": protein,
      "foodName": foodName,
      'datetime': formattedDate,
    });
    res = 'success';
  } catch (err) {
    res = err.toString();
  }
  return res;
}
