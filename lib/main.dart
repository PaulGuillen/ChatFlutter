import 'package:chat_flutter/src/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Delivery App Flutter',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context ) => LoginPage()
      },
    );
  }
}
