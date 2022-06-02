import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:get/get.dart';

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