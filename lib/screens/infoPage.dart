// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class infoPage extends StatefulWidget {
  const infoPage({Key? key}) : super(key: key);

  @override
  State<infoPage> createState() => _infoPageState();
}

enum gender { Male, Female }

class _infoPageState extends State<infoPage> {
  final _formKey = GlobalKey<FormState>();

  validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      setState(() {
        validated = true;
      });
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

  concludedData() {
    print(_character);
    print(dropdownValue);
    print(HeightController.text);
    print(WeightController.text);
    print(AgeController.text);

    return Column(
      children: [
        Text("Gender: " + _character.toString()),
        Text("Activity: " + dropdownValue),
        Text("Height: " + HeightController.text),
        Text("Weight: " + WeightController.text),
        Text("Age: " + AgeController.text),
      ],
    );
  }

  gender? _character = gender.Male;
  String dropdownValue = 'Light: Exercise 1-3 times/week';
  final TextEditingController HeightController = new TextEditingController();
  final TextEditingController AgeController = new TextEditingController();
  final TextEditingController WeightController = new TextEditingController();

  bool validated = false;

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
                SizedBox(height: 15),
                MaterialButton(
                  color: Color.fromARGB(255, 56, 80, 188),
                  child: Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    validation();
                  },
                ),
                SizedBox(height: 15),
                validated ? concludedData() : Container(),
              ],
            ),
          ),
        ));
  }
}
