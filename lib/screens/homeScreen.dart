// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
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
  String user_email = "afreshuser2@gmail.com";

  double totalCaloriesConsumed = 0;
  Map<String, double> dataMap = {
    "Carbs": 0,
    "Protein": 0,
    "Fats": 0,
  };

  final colorList = <Color>[
    Colors.black,
    Colors.red,
    Colors.blue,
  ];

  @override
  void initState() {
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
                  dataMap['Carbs'] = totalCarbs;
                  dataMap['Protein'] = totalProtein;
                  dataMap['Fats'] = totalFats;
                  totalCaloriesConsumed = totalCals;
                });
              }
              start++;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyCalorieTracker"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: PieChart(
                centerText: totalCaloriesConsumed.toString() + "kcal",
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
          Navigator.push(
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
