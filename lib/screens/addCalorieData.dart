// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipe_flutter/screens/homeScreen.dart';
import 'package:receipe_flutter/services/database.dart';

class addCalorie extends StatefulWidget {
  const addCalorie({Key? key}) : super(key: key);

  @override
  State<addCalorie> createState() => _addCalorieState();
}

class _addCalorieState extends State<addCalorie> {
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

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

  addToDatabase() {
    String res = freshCalorieSetter(
        user!.email,
        calorieController.text,
        carbsController.text,
        fatsController.text,
        proteinController.text,
        foodNameController.text);
    if (res == "success") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => homeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
      print(res);
    }
  }

  final TextEditingController foodNameController = new TextEditingController();
  final TextEditingController carbsController = new TextEditingController();
  final TextEditingController proteinController = new TextEditingController();
  final TextEditingController fatsController = new TextEditingController();
  final TextEditingController calorieController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 162, 173, 179),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 121, 12, 116),
        title: Text(
          "My Calorie Tracker",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 17.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: foodNameController,
                validator: (value) {
                  if (value == '') {
                    return 'You must enter a value';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Food name',
                  icon: Icon(Icons.trending_up),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: calorieController,
                validator: (value) {
                  if (value == '') {
                    return 'You must enter a value';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Calories (kcal)',
                  icon: Icon(Icons.trending_up),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: carbsController,
                validator: (value) {
                  if (value == '') {
                    return 'You must enter a value';
                  } else if (isNumeric(value!) == false) {
                    return 'Enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Carbohydrates (gm)',
                  icon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: proteinController,
                validator: (value) {
                  if (value == '') {
                    return 'You must enter a value';
                  } else if (isNumeric(value!) == false) {
                    return 'Enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Protein (gm)',
                  icon: Icon(Icons.line_weight),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: fatsController,
                validator: (value) {
                  if (value == '') {
                    return 'You must enter a value';
                  } else if (isNumeric(value!) == false) {
                    return 'Enter a number';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Fats (gm)',
                  icon: const Icon(Icons.add),
                ),
              ),
              SizedBox(height: 15),
              MaterialButton(
                height: 50,
                minWidth: 80,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromARGB(255, 5, 0, 5))),
                color: Color.fromARGB(255, 121, 12, 116),
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (validation()) {
                    addToDatabase();
                  }
                },
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
