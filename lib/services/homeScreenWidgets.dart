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
            return Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Color.fromARGB(255, 1, 15, 26),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      "Food : " +
                          snapshot.data!.docs[index].get("foodName").toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 0, 0),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Calories : " +
                          snapshot.data!.docs[index].get("calories").toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 0, 0),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Carbohydrates : " +
                          snapshot.data!.docs[index].get("carbs").toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 0, 0),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Fats : " +
                          snapshot.data!.docs[index].get("fats").toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 0, 0),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Proteins : " +
                          snapshot.data!.docs[index].get("protein").toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 0, 0),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
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