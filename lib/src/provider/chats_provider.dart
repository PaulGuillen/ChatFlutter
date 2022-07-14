import 'package:chat_flutter/src/models/chat.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/environment.dart';

class ChatsProvider extends GetConnect {

  String url = Environment.API_CHAT + 'api/chats';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Chat>> getChats() async {
    Response response = await get(
        '$url/findByIdUser/${user.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    );

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido obtener esta informacion');
      return [];
    }

    List<Chat> chats = Chat.fromJsonList(response.body);

    return chats;
  }

  Future<ResponseApi> create(Chat chat) async {
    Response response = await post(
        '$url/create',
        chat.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    ); // ESTA LINEA

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo actualizar el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

}