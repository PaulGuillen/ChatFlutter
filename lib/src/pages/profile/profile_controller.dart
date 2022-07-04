import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }

  void goToProfileEdit(){
    Get.toNamed('/profile/edit');
  }
}