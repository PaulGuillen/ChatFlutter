import 'dart:convert';
import 'dart:io';

import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MessagesController extends GetxController {

  TextEditingController messageController = TextEditingController();

  User userChat = User.fromJson(Get.arguments['user']);

  MessagesController() {
    print('Usuario chat: ${userChat.toJson()}');

  }
}