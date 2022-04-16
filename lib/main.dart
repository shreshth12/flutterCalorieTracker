import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:receipe_flutter/screens/infoPage.dart';
import 'package:receipe_flutter/screens/signIn.dart';
import 'package:receipe_flutter/screens/signUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  String apiKey = dotenv.get('apiKey', fallback: 'sane-default');
  String appId = dotenv.get('appId', fallback: 'sane-default');
  String messagingSenderId =
      dotenv.get('messagingSenderId', fallback: 'sane-default');
  String projectId = dotenv.get('projectId', fallback: 'sane-default');
  String storageBucket = dotenv.get('storageBucket', fallback: 'sane-default');

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = true;

  @override
  void initState() {
    // TODO: implement initState
    // getLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn == true ? signUp() : infoPage(),
    );
  }
}
