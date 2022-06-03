import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:chat_flutter/src/provider/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  GetStorage storage = GetStorage();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        User user = User.fromJson(responseApi.data);
        storage.write('user', user.toJson());
        goToHomePage();
        Get.snackbar('Usuario Logeado', 'Se encontro el usuario');
      }
      else {
        Get.snackbar('Error de sesion', 'No se ha podido iniciar sesion');
      }

    }
    else {
      Get.snackbar('Completa los datos', 'Ingresa el email y el password');
    }

  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

}