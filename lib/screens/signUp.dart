// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:receipe_flutter/screens/infoPage.dart';
import 'package:receipe_flutter/services/authentication.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final _formKey = GlobalKey<FormState>();

  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();

  bool _isLoading = false;

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: emailEditingController.text,
        password: passwordEditingController.text,
        username: userNameEditingController.text);

    if (res == 'success') {
      AuthMethods().loginUser(
          email: emailEditingController.text,
          password: passwordEditingController.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => infoPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
      print(res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  validation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userNameField = TextFormField(
      validator: (value) {
        if (value == "") {
          return "Enter a value";
        }
      },
      autofocus: false,
      controller: userNameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        userNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      validator: (value) {
        if (value == "") {
          return "Enter a value";
        } else if (!value!.contains("@")) {
          return "This is not an email";
        }
      },
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordField = TextFormField(
      validator: (value) {
        if (value == "") {
          return "Enter a value";
        }
      },
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final signUpButton = Material(
      elevation: 5,
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => {
          if (validation()) {signUpUser()}
        },
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/images/myImage.jpeg",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 20),
                      userNameField,
                      SizedBox(height: 30),
                      emailField,
                      SizedBox(height: 30),
                      passwordField,
                      SizedBox(height: 30),
                      signUpButton,
                      SizedBox(height: 15),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
