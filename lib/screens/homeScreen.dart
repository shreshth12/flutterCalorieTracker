// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:receipe_flutter/screens/addCalorieData.dart';
import 'package:receipe_flutter/services/database.dart';
import 'package:receipe_flutter/services/homeScreenWidgets.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  String user_email = "afreshuser2@gmail.com";

  setUserCorrect() {
    user_email = user!.email!;
  }

  double totalCaloriesConsumed = 0;
  int BMR = 0;
  Map<String, double> dataMap = {
    "Carbs (gm)": 0,
    "Protein (gm)": 0,
    "Fats (gm)": 0,
  };

  final colorList = <Color>[
    Colors.black,
    Colors.red,
    Colors.blue,
  ];

  @override
  void initState() {
    setUserCorrect();
    double totalCarbs = 0;
    double totalProtein = 0;
    double totalFats = 0;
    double totalCals = 0;
    int start = 1;
    FirebaseFirestore.instance
        .collection('tracker')
        .where('user', isEqualTo: user_email)
        .get()
        .then((value) => value.docs.forEach((element) {
              totalCarbs += double.parse(element.data()['carbs']);
              totalProtein += double.parse(element.data()['protein']);
              totalFats += double.parse(element.data()['fats']);
              totalCals += double.parse(element.data()['calories']);

              // print(element.data()['carbs']);

              if (start == value.docs.length) {
                setState(() {
                  dataMap['Carbs (gm)'] = totalCarbs;
                  dataMap['Protein (gm)'] = totalProtein;
                  dataMap['Fats (gm)'] = totalFats;
                  totalCaloriesConsumed = totalCals;
                });
              }
              start++;
            }));

    FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user_email)
        .get()
        .then((value) => {
              setState(() {
                BMR = value.docs[0].get('BMR');
              })
            });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyCalorieTracker"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: 350,
              child: PieChart(
                centerText: totalCaloriesConsumed.toString() +
                    "/" +
                    BMR.toString() +
                    " kCal",
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey,
                colorList: colorList,
              ),

              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ),
            Container(
                height: 800,
                width: 800,
                child: userIndividualWidget(user_email)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const addCalorie()),
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
