import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  var tabIndex = 0.obs;

  HomeController() {
    print('USUARIO DE SESION: ${user.toJson()}');
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

}