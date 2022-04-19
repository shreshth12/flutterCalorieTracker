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
    FirebaseFirestore.instance
        .collection('tracker')
        .where('user', isEqualTo: user_email)
        .get()
        .then((value) => value.docs.forEach((element) {
              setState(() {
                dataMap['Carbs'] = double.parse(element.data()['carbs']);
                dataMap['Protein'] = double.parse(element.data()['protein']);
                dataMap['Fats'] = double.parse(element.data()['fats']);
              });
              print(element.data()['carbs']);
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
                // centerText: "",
                dataMap: dataMap,
                chartType: ChartType.disc,
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
          // Add your onPressed code here!

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
