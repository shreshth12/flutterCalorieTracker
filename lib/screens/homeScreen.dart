import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:receipe_flutter/screens/addCalorieData.dart';
import 'package:receipe_flutter/services/database.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('tracker')
      .where('user', isEqualTo: "afreshuser2@gmail.com")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("MyCalorieTracker"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              pieView(),
              Container(
                height: 500,
                width: 500,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Container(
                          child: Column(
                            children: [
                              Text(data['user'].toString()),
                              Text(data['calories'].toString()),
                              Text(data['carbs'].toString()),
                              Text(data['fats'].toString()),
                              Text(data['protein'].toString()),
                              Text(data['foodName'].toString()),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
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

class pieView extends StatefulWidget {
  const pieView({Key? key}) : super(key: key);

  @override
  State<pieView> createState() => _pieViewState();
}

class _pieViewState extends State<pieView> {
  Map<String, double> dataMap = {
    "Carbs": 0,
    "Protein": 0,
    "Fats": 10,
  };

  final colorList = <Color>[
    Colors.black,
    Colors.red,
    Colors.blue,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: PieChart(
        centerText: "Total consumed : 1276/2400",
        dataMap: dataMap,
        chartType: ChartType.disc,
        baseChartColor: Colors.grey,
        colorList: colorList,
      ),

      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
