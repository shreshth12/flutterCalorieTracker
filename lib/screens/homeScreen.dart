import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:receipe_flutter/services/database.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  printData() {
    userDataRetriever("afreshuser2@gmail.com");
  }

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
    printData();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Calorie tracker'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 56, 80, 188),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
              ),
            ],
          ),
        ));
  }
}
