import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  try {
    FirebaseFirestore.instance.collection('tracker').add({
      "user": user,
      "calories": calories,
      "carbs": carbs,
      "fats": fats,
      "protein": protein,
      "foodName": foodName
    });
    res = 'success';
  } catch (err) {
    res = err.toString();
  }
  return res;
}
