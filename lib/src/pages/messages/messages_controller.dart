import 'dart:convert';
import 'dart:io';

import 'package:chat_flutter/src/models/chat.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:chat_flutter/src/provider/chats_provider.dart';
import 'package:chat_flutter/src/provider/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MessagesController extends GetxController {

  TextEditingController messageController = TextEditingController();

  User userChat = User.fromJson(Get.arguments['user']);
  User myUser = User.fromJson(GetStorage().read('user') ?? {});

  ChatsProvider chatsProvider = ChatsProvider();
  MessagesProvider messagesProvider = MessagesProvider();

  String idChat = '';

  MessagesController() {
    print('Usuario chat: ${userChat.toJson()}');
    createChat();

  }

  void createChat() async {
    Chat chat = Chat(
        idUser1: myUser.id,
        idUser2: userChat.id
    );

    ResponseApi responseApi = await chatsProvider.create(chat);
    if (responseApi.success == true) {
      idChat = responseApi.data as String;
      // getMessages();
      // listenMessage();
      // listenWriting();
      // listenMessageSeen();
      // listenOffline();
      // listenMessageReceived();
    }
    // Get.snackbar('Chat creado', responseApi.message ?? 'Error en la respuesta');
  }

  void sendMessage() async {
    String messageText = messageController.text;

    if (messageText.isEmpty) {
      Get.snackbar('Texto vacio', 'Ingresa el mensaje que quieres enviar');
      return;
    }

    if (idChat == '') {
      Get.snackbar('Error', 'No se pudo enviar el mensaje');
      return;
    }

    Message message = Message(
        message: messageText,
        idSender: myUser.id,
        idReceiver: userChat.id,
        idChat: idChat,
        isImage: false,
        isVideo: false
    );

    ResponseApi responseApi = await messagesProvider.create(message);

    if (responseApi.success == true) {
      messageController.text = '';
    /*  emitMessage();*/
/*      sendNotification(messageText, responseApi.data as String);*/
    }

  }

}