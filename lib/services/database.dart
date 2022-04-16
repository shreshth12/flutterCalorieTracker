import 'package:cloud_firestore/cloud_firestore.dart';

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

  // .then((value) => {res = 'success'})
  // .catchError((error) => {res = error});
  return res;
}
