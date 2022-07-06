import 'package:get/get.dart';
import '../../models/users.dart';
import '../../provider/users_provider.dart';

class UsersController extends GetxController {

  UsersProvider usersProvider = UsersProvider();

  Future<List<User>> getUsers() async {
    return await usersProvider.getUsers();
  }

  void goToChat(User user) {
    Get.toNamed('/messages', arguments: {
      'user': user.toJson()
    });
  }

}