import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('EMAIL: $email');
    print('PASSWORD: ${password}');
  }

}