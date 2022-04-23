// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:receipe_flutter/screens/addCalorieData.dart';
import 'package:receipe_flutter/screens/signIn.dart';
import 'package:receipe_flutter/services/authentication.dart';
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
    Color.fromARGB(255, 29, 20, 125),
    Color.fromARGB(255, 148, 43, 36),
    Color.fromARGB(255, 70, 131, 10),
  ];

  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    setUserCorrect();
    double totalCarbs = 0;
    double totalProtein = 0;
    double totalFats = 0;
    double totalCals = 0;
    int start = 1;

    //This is to check if its a new day, if yes, remove all data and start fresh
    try {
      FirebaseFirestore.instance
          .collection('tracker')
          .where('user', isEqualTo: user_email)
          .get()
          .then((value) => {
                if (value.docs[0].get('datetime') != formattedDate)
                  {deleteData()}
              });
    } catch (err) {
      print(err);
    }

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
      backgroundColor: Color.fromARGB(255, 162, 173, 179),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 12, 116),
        automaticallyImplyLeading: false,
        title: Text(
          "My Calorie Tracker",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 17.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Are you sure'),
                        content: const Text('you want to log out?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context, 'OK'),
                              AuthMethods().signOut(),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          signIn()))
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    )
                  }),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 400,
                width: 400,
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
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 800,
                  width: 800,
                  child: userIndividualWidget(user_email)),
            ],
          ),
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
        backgroundColor: Color.fromARGB(255, 121, 12, 116),
      ),
    );
  }
}



// Container(
//               height: 350,
//               width: 350,
//               child: PieChart(
//                 centerText: totalCaloriesConsumed.toString() +
//                     "/" +
//                     BMR.toString() +
//                     " kCal",
//                 dataMap: dataMap,
//                 chartType: ChartType.ring,
//                 baseChartColor: Colors.grey,
//                 colorList: colorList,
//               ),

//               // gradientList: ---To add gradient colors---
//               // emptyColorGradient: ---Empty Color gradient---
//             ),
//             Container(
//                 height: 800,
//                 width: 800,
//                 child: userIndividualWidget(user_email)),