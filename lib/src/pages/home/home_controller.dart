import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  var tabIndex = 0.obs;


  Socket socket = io('${Environment.API_CHAT}chat', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false
  });

  HomeController() {
    print('USUARIO DE SESION: ${user.toJson()}');
    connectAndListen();
  }

  void connectAndListen() {
    if (user.id != null) {
      socket.connect();
      socket.onConnect((data) {
        print('USUARIO CONECTADO A SOCKET IO');

      });
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    socket.disconnect();
  }


  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

}