// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipe_flutter/screens/homeScreen.dart';
import 'package:receipe_flutter/services/database.dart';

class infoPage extends StatefulWidget {
  const infoPage({Key? key}) : super(key: key);

  @override
  State<infoPage> createState() => _infoPageState();
}

enum gender { Male, Female }

class _infoPageState extends State<infoPage> {
  final _formKey = GlobalKey<FormState>();

  User? current_user = FirebaseAuth.instance.currentUser;

  validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  concludedData() async {
    double BMR = 0;
    var W = int.parse(WeightController.text);
    var H = int.parse(HeightController.text);
    var A = int.parse(AgeController.text);

    if (_character.toString() == 'gender.Male') {
      BMR = (13.397 * W + 4.799 * H - 5.677 * A + 88.362);
    } else {
      BMR = (9.247 * W + 3.098 * H - 4.330 * A + 447.593);
    }

    if (dropdownValue.toString() == "Light: Exercise 1-3 times/week") {
      BMR = BMR * 1.2;
    } else if (dropdownValue.toString() ==
        'Moderate: Exercise 4-5 times/week') {
      BMR = BMR * 1.5;
    } else {
      BMR = BMR * 1.9;
    }

    if (dropdownValue2.toString() == "Lose weight: 1lb per week") {
      BMR = BMR - 300;
    } else if (dropdownValue2.toString() == 'Lose weight fast: 2lb per week') {
      BMR = BMR - 600;
    } else if (dropdownValue2.toString() == 'Gain weight') {
      BMR = BMR + 350;
    }

    String res = addDataToUser(BMR, current_user!.uid);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => homeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
      print(res);
    }
  }

  gender? _character = gender.Male;
  String dropdownValue = 'Light: Exercise 1-3 times/week';
  String dropdownValue2 = 'Lose weight: 1lb per week';
  final TextEditingController HeightController = new TextEditingController();
  final TextEditingController AgeController = new TextEditingController();
  final TextEditingController WeightController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter details'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 56, 80, 188),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: HeightController,
                  validator: (value) {
                    if (value == '') {
                      return 'You must enter a value';
                    } else if (isNumeric(value!) == false) {
                      return 'Enter a number';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Height in cm',
                    icon: Icon(Icons.trending_up),
                  ),
                ),
                TextFormField(
                  controller: AgeController,
                  validator: (value) {
                    if (value == '') {
                      return 'You must enter a value';
                    } else if (isNumeric(value!) == false) {
                      return 'Enter a number';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Age',
                    icon: Icon(Icons.person),
                  ),
                ),
                TextFormField(
                  controller: WeightController,
                  validator: (value) {
                    if (value == '') {
                      return 'You must enter a value';
                    } else if (isNumeric(value!) == false) {
                      return 'Enter a number';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Weight in kg',
                    icon: Icon(Icons.line_weight),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Gender",
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio<gender>(
                        value: gender.Male,
                        groupValue: _character,
                        onChanged: (gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio<gender>(
                        value: gender.Female,
                        groupValue: _character,
                        onChanged: (gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Activity Level",
                  textAlign: TextAlign.left,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    'Light: Exercise 1-3 times/week',
                    'Moderate: Exercise 4-5 times/week',
                    'Active: Exercise everyday'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: <String>[
                    'Lose weight: 1lb per week',
                    'Lose weight fast: 2lb per week',
                    'Maintain Weight',
                    'Gain weight',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                MaterialButton(
                  color: Color.fromARGB(255, 56, 80, 188),
                  child: Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (validation()) {
                      concludedData();
                    }
                  },
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }
}
