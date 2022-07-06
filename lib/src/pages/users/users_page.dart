import 'package:chat_flutter/src/pages/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {

  UsersController con = Get.put(UsersController());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text('Users Page'),
      ),
    );
  }

}
