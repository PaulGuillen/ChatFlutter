import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class UsersProvider extends GetConnect {

  String url = Environment.API_CHAT + 'api/users';

  Future<Response> create(User user) async {
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
      'Content-Type': 'application/json'
      }
    );
    return response;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri url = Uri.http(Environment.API_CHAT_OLD, '/api/users/create');
    final request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future <ResponseApi> createUserWithImage(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/create', form);
    if (response.body == null) {
      Get.snackbar("Error en la peticion", "No se pudo crear el usuario");
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {

    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion de login');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

}