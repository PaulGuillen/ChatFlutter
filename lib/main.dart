import 'package:chat_flutter/src/models/users.dart';
import 'package:chat_flutter/src/pages/home/home_page.dart';
import 'package:chat_flutter/src/pages/login/login_page.dart';
import 'package:chat_flutter/src/pages/profile_edit/profile_edit_page.dart';
import 'package:chat_flutter/src/pages/register/register_page.dart';
import 'package:chat_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User myUser = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
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
      initialRoute: myUser.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/' , page:() => LoginPage()),
        GetPage(name: '/register' , page:() => RegisterPage()),
        GetPage(name: '/home' , page:() => HomePage()),
        GetPage(name: '/profile/edit' , page:() => ProfileEditPage()),
      ],
      theme: ThemeData(
          // colorScheme: const ColorScheme.light().copyWith(primary: MyColors.primaryColor),
          primaryColor: MyColors.primaryColor
      ),
      navigatorKey: Get.key,
    );
  }
}
