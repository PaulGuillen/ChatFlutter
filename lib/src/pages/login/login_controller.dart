import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/provider/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        Get.snackbar('Usuario Logeado', 'Se encontro el usuario');
      }
      else {
        Get.snackbar('Error de sesion', 'no se ha podido iniciar sesion');
      }

    }
    else {
      Get.snackbar('Completa los datos', 'Ingresa el email y el password');
    }

  }

}