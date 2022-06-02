import 'package:chat_flutter/src/pages/login/login_page.dart';
import 'package:chat_flutter/src/pages/register/register_page.dart';
import 'package:chat_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return  GetMaterialApp(
      title: 'Chat App Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/' , page:() => LoginPage()),
        GetPage(name: '/register' , page:() => RegisterPage()),
      ],
      theme: ThemeData(
          // colorScheme: const ColorScheme.light().copyWith(primary: MyColors.primaryColor),
          primaryColor: MyColors.primaryColor
      ),
      navigatorKey: Get.key,
    );
  }
}
