import 'dart:convert';
import 'dart:io';

import 'package:chat_flutter/src/models/chat.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../api/environment.dart';

class MessagesProvider  extends GetConnect {

  String url = Environment.API_CHAT + 'api/messages';

  User user = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Message>> getMessagesByChat(String idChat) async {
    Response response = await get(
        '$url/findByChat/$idChat',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    );

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido obtener esta informacion');
      return [];
    }

    List<Message> messages = Message.fromJsonList(response.body);

    return messages;
  }


  Future<ResponseApi> create(Message message) async {
    Response response = await post(
        '$url/create',
        message.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    ); // ESTA LINEA

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo con el mensaje');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<Stream> createWithImage(Message message, File image) async {
    Uri url = Uri.http(Environment.API_CHAT_OLD, '/api/messages/createWithImage');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = user.sessionToken!;
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['message'] = json.encode(message);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

}