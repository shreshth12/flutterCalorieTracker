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

userDataRetriever(var user_email) async {
  await FirebaseFirestore.instance
      .collection('tracker')
      .where('user', isEqualTo: user_email)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["calories"]);
      return doc["calories"];
    });
  });
}
