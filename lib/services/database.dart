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

freshCalorieSetter(var user) {
  FirebaseFirestore.instance
      .collection('tracker')
      .add({"user": user, "calories": 0, "carbs": 0, "fats": 0, "protein": 0})
      .then((value) => print("Calorie Data Added"))
      .catchError((error) => print("Failed to add data: $error"));
}

userDataRetriever(var user_email) {
  print(FirebaseFirestore.instance
      .collection('tracker')
      .where('user', isEqualTo: user_email)
      .get());
}
