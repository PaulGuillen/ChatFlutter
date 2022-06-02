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

    if(isValidForm(email, name, lastname, phone, password, confirmPassword)){

      User user = User(
          email: email,
          name:  name,
          lastname: lastname,
          phone: phone,
          password: password
      );

      Response  response =  await usersProvider.create(user);

      if(response.body['success'] == true){
        clearForm();
        Get.snackbar('Formulario valido', 'Registro exitoso');
      }

      print('Response: ${response.body}');

    }
  }

  bool isValidForm(String email, String name, String lastname, String phone , String password, String confirmPassword){

    if(email.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu correco electrónico');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no válido','El correo que has ingresado no es válido');
      return false;
    }

    if(name.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu nombre');
      return false;
    }

    if(lastname.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu apellido');
      return false;
    }

    if(phone.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu número de teléfono');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu contraseña');
      return false;
    }

    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar la confirmación de contraseña');
      return false;
    }

    if(password != confirmPassword){
      Get.snackbar('Formulario no válido', 'Las contraseñas no coinciden');
      return false;
    }
    return true;

  }

  void clearForm(){
    emailController.text = '';
    nameController.text = '';
    lastnameController.text = '';
    phoneController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }
}