import 'package:chat_flutter/src/api/environment.dart';
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
}