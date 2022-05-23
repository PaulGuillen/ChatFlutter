import 'package:chat_flutter/src/models/users.dart';
import 'package:chat_flutter/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async {

    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email: $email');
    print('name: $name');
    print('lastname: $lastname');
    print('phone: $phone');
    print('password: $password');
    print('confirmPassword: $confirmPassword');

    User user = User(
      email: email,
      name:  name,
      lastname: lastname,
      phone: phone,
      password: password
    );

    Response  response =  await usersProvider.create(user);

    print('Response: ${response.body}');
  }

}