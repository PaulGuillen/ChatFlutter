import 'package:chat_flutter/src/login/login_page.dart';
import 'package:chat_flutter/src/utils/my_colors.dart';
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
      title: 'Chat App Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context ) => const LoginPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(primary: MyColors.primaryColor),
      ),
    );
  }
}
