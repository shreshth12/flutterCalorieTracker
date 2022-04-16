import 'package:cloud_firestore/cloud_firestore.dart';

addDataToUser(double calculatedBMR, String uid) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set(
        {'BMR': calculatedBMR.round()},
        SetOptions(merge: true),
      )
      .then((value) => print("merged with existing data!"))
      .catchError((error) => print("Failed to merge data: $error"));
}
