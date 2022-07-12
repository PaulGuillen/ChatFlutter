import 'dart:convert';
import 'dart:io';

import 'package:chat_flutter/src/models/chat.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/models/response_api.dart';
import 'package:chat_flutter/src/models/users.dart';
import 'package:chat_flutter/src/pages/home/home_controller.dart';
import 'package:chat_flutter/src/provider/chats_provider.dart';
import 'package:chat_flutter/src/provider/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class MessagesController extends GetxController {

  TextEditingController messageController = TextEditingController();

  User userChat = User.fromJson(Get.arguments['user']);
  User myUser = User.fromJson(GetStorage().read('user') ?? {});

  ImagePicker picker = ImagePicker();
  File? imageFile;

  ChatsProvider chatsProvider = ChatsProvider();
  MessagesProvider messagesProvider = MessagesProvider();


  ScrollController scrollController =  ScrollController();

  String idChat = '';
  List<Message> messages = <Message>[].obs; // GETX

  HomeController homeController = Get.find();

  MessagesController() {
    print('Usuario chat: ${userChat.toJson()}');
    createChat();

  }

  void listenMessage() {
    homeController.socket.on('message/$idChat', (data) {
      print('DATA EMITIDA $data');
      getMessages();
    });
  }


  void getMessages() async {
    var result = await messagesProvider.getMessagesByChat(idChat);
    messages.clear();
    messages.addAll(result);

    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    });
  }


  void createChat() async {
    Chat chat = Chat(
        idUser1: myUser.id,
        idUser2: userChat.id
    );

    ResponseApi responseApi = await chatsProvider.create(chat);
    if (responseApi.success == true) {
      idChat = responseApi.data as String;
        getMessages();
        listenMessage();
      // listenWriting();
      // listenMessageSeen();
      // listenOffline();
      // listenMessageReceived();
    }
    // Get.snackbar('Chat creado', responseApi.message ?? 'Error en la respuesta');
  }

  void emitMessage() {
    homeController.socket.emit('message', {
      'id_chat': idChat
 /*     'id_user': userChat.id*/
    });
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
      emitMessage();
/*      sendNotification(messageText, responseApi.data as String);*/
    }

  }


  Future<File?> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 80
    );

    return result;
  }

  Future selectVideo(ImageSource imageSource, BuildContext context) async {
    final XFile? video = await picker.pickVideo(source: imageSource);

    if (video != null) {
      File videoFile = File(video.path);

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Subiendo video...');

      Message message = Message(
          message: 'VIDEO',
          idSender: myUser.id,
          idReceiver: userChat.id,
          idChat: idChat,
          isImage: false,
          isVideo: true
      );

      Stream stream = await messagesProvider.createWithVideo(message, videoFile);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          emitMessage();
        }

      });
    }
  }

  Future selectImage(ImageSource imageSource, BuildContext context) async {
    final XFile? image = await picker.pickImage(source: imageSource);

    if(image != null){
      imageFile = File(image.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = dir.absolute.path + "/temp.jpg";

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Subiendo imagen...');

      File? compressFile = await compressAndGetFile(imageFile!, targetPath); // COMPRIMIR EL ARCHIVO

      Message message = Message(
          message: 'IMAGEN',
          idSender: myUser.id,
          idReceiver: userChat.id,
          idChat: idChat,
          isImage: true,
          isVideo: false
      );

      Stream stream = await messagesProvider.createWithImage(message, compressFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          emitMessage();
        }

      });

    }
  }


  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery, context);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera, context);
        },
        child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }

  void showAlertDialogForVideo(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectVideo(ImageSource.gallery, context);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectVideo(ImageSource.camera, context);
        },
        child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona el video'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }

}