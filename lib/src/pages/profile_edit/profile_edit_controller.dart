import 'dart:convert';
import 'dart:io';

import 'package:chat_flutter/src/models/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../models/response_api.dart';
import '../../provider/users_provider.dart';
import '../profile/profile_controller.dart';

class ProfileEditController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  User user = User.fromJson(GetStorage().read('user') ?? {});


  UsersProvider usersProvider = UsersProvider();

  ProfileController profileController = Get.find();

  ProfileEditController() {
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }


  void updateUser(BuildContext context) async {

    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    User u = User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
        email: user.email,
        sessionToken: user.sessionToken,
    );

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: 'Actualizando datos...');

    Stream stream = await usersProvider.updateWithImage(u, imageFile!);
    stream.listen((res) {

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      progressDialog.close();

      print('Usuario actualizado ${responseApi.data}');

      if (responseApi.success == true) {

        GetStorage().write('user', responseApi.toJson());
        Get.snackbar('Usuario Actualizado', responseApi.message!);
      }
      else {
        Get.snackbar('No se pudo actualizar el usuario', responseApi.message!);
      }
    });


  }

  Future selectImage(ImageSource imageSource) async {
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update(); // SET STATE
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
