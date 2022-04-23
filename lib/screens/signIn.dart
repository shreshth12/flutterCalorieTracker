// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:receipe_flutter/services/authentication.dart';
import 'package:receipe_flutter/screens/homeScreen.dart';
import 'package:receipe_flutter/screens/signUp.dart';

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => homeScreen()));
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
    final emailField = TextFormField(
      validator: (value) {
        if (value == "") {
          return "Enter a value";
        } else if (!value!.contains("@")) {
          return "This is not an email";
        }
      },
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
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
      obscureText: true,
      controller: passwordController,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final loginButton = Material(
      elevation: 5,
      color: Color.fromARGB(255, 121, 12, 116),
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => {
          if (validation()) {loginUser()}
        },
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            // ignore: prefer_const_constructors
            : Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );

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
                      SizedBox(height: 30),
                      emailField,
                      SizedBox(height: 35),
                      passwordField,
                      SizedBox(height: 45),
                      loginButton,
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => signUp())));
                            },
                            child: Text("Sign up!",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 121, 12, 116),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
