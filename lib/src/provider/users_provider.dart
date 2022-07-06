import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:get_storage/get_storage.dart';

class UsersProvider extends GetConnect {


  String url = Environment.API_CHAT + 'api/users';

  User user = User.fromJson(GetStorage().read('user') ?? {});


  Future<List<User>> getUsers() async {
    Response response = await get(
        '$url/getAll/${user.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    );

    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'tu usuario no tiene permitido obtener esta informacion');
      return [];
    }

    List<User> users = User.fromJsonList(response.body);

    return users;
  }

  Future<Response> checkIfIsOnline(String idUser) async {
    Response response = await get(
        '$url/checkIfIsOnline/$idUser',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': user.sessionToken!
        }
    );

    return response;
  }


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

  Future<Stream> updateWithImage(User user, File image) async {
    Uri url = Uri.http(Environment.API_CHAT_OLD, '/api/users/updateWithImage');
    final request = http.MultipartRequest('PUT', url);
    request.headers['Authorization'] = user.sessionToken!;
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

  Future<ResponseApi> update(User user) async {
    Response response = await put(
        '$url/update',
        user.toJson(),
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