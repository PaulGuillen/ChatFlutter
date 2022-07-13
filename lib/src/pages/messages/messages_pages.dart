import 'package:chat_flutter/src/api/environment.dart';
import 'package:chat_flutter/src/models/message.dart';
import 'package:chat_flutter/src/pages/messages/messages_controller.dart';
import 'package:chat_flutter/src/utils/bubble.dart';
import 'package:chat_flutter/src/utils/bubble_image.dart';
import 'package:chat_flutter/src/utils/bubble_video.dart';
import 'package:chat_flutter/src/utils/relative_time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesPage extends StatelessWidget {
  MessagesController con = Get.put(MessagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 246, 248, 1),
      body: Obx(
        () => Column(
          children: [
            customAppBar(),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListView(
                    reverse: true,
                      controller: con.scrollController,
                    children: getMessages(),
                  ),
                )),
            messagesBox(context)
          ],
        ),
      ),
    );
  }

  List<Widget> getMessages() {
    return con.messages.map((message) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: message.idSender == con.myUser.id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: bubbleMessage(message),
      );
    }).toList();
  }

  Widget bubbleMessage(Message message) {

    if (message.isImage == true) {
      return BubbleImage(
        message: message.message ?? '',
        time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
        delivered: true,
        isMe: message.idSender == con.myUser.id ? true: false,
        status: message.status ?? 'ENVIADO',
        isImage: true,
        url: message.url ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      );
    }

    if (message.isVideo == true) {
      return BubbleVideo(
        message: message.message ?? '',
        time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
        delivered: true,
        isMe: message.idSender == con.myUser.id ? true: false,
        status: message.status ?? 'ENVIADO',
        url: message.url ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        videoController: message.controller,
      );
    }



    return Bubble(
      message: message.message ?? '',
      delivered: true,
      isMe: message.idSender == con.myUser.id ? true : false,
      status: message.status ?? 'ENVIADO',
      time: RelativeTimeUtil.getRelativeTime(message.timestamp ?? 0),
    );
  }

  Widget messagesBox(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 15,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () => con.showAlertDialog(context),
                icon: Icon(Icons.image_outlined),
              )),
          Expanded(
              flex: 1,
              child: IconButton(
                onPressed: ()  => con.showAlertDialogForVideo(context),
                icon: Icon(Icons.video_call_rounded),
              )),
          Expanded(
              flex: 10,
              child: TextField(
                onChanged: (String text) {
                  con.emitWriting();
                },
                controller: con.messageController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escribe tu mensaje...',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
              )),
          Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () => con.sendMessage(),
                icon: Icon(Icons.send),
              ))
        ],
      ),
    );
  }

  Widget customAppBar() {
    return SafeArea(
      child: ListTile(
        title: Text(
          '${con.userChat.name ?? ''} ${con.userChat.lastname ?? ''}',
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold),
        ),
        subtitle: con.isWriting.value == true
            ? Text(
          'Escribiendo....',
          style: TextStyle(color: Colors.green),
        ):
        Text(
          'Desconectado',
          style: TextStyle(color: Colors.grey),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        trailing: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/img/user_profile_2.png',
                  image: con.userChat.image ?? Environment.IMAGE_URL),
            ),
          ),
        ),
      ),
    );
  }
}
