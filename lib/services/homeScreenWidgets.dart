// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:receipe_flutter/services/database.dart';

Widget userIndividualWidget(String user_email) {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('tracker')
      .where('user', isEqualTo: user_email)
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(snapshot.data!.docs[index].get("user").toString()),
                Text(snapshot.data!.docs[index].get("calories").toString()),
                Text(snapshot.data!.docs[index].get("carbs").toString()),
                Text(snapshot.data!.docs[index].get("fats").toString()),
                Text(snapshot.data!.docs[index].get("protein").toString()),
                Text(snapshot.data!.docs[index].get("foodName").toString()),
              ],
            );
          },
        );
      } else {
        return Text(
            "You do not have any data, please enter from the button below");
      }
    },
  );
}

Widget userBmrWidget(String user_email) {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: user_email)
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            return Text(snapshot.data!.docs[index].get("BMR").toString());
          },
        );
      } else {
        return Text(
            "You do not have any data, please enter from the button below");
      }
    },
  );
}









// Widget userIndividualWidget(String user_email) {
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//       .collection('tracker')
//       .where('user', isEqualTo: user_email)
//       .snapshots();

//   return Container(
//     height: 500,
//     width: 500,
//     child: StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }
//         if (snapshot.hasData) {
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data()! as Map<String, dynamic>;
//               return Container(
//                 child: Column(
//                   children: [
//                     Text(data['user'].toString()),
//                     Text(data['calories'].toString()),
//                     Text(data['carbs'].toString()),
//                     Text(data['fats'].toString()),
//                     Text(data['protein'].toString()),
//                     Text(data['foodName'].toString()),
//                     SizedBox(
//                       height: 20,
//                     )
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//         } else {
//           return Text(
//               "You do not have any data, please enter from the button below");
//         }
//       },
//     ),
//   );
// }