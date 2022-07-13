import 'dart:convert';

import 'package:video_player/video_player.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {

  String? id;
  String? message;
  String? idReceiver;
  String? idSender;
  String? idChat;
  String? status;
  String? url;
  bool? isImage;
  bool? isVideo;
  int? timestamp;
  VideoPlayerController? controller;

  Message({
    this.id,
    this.message,
    this.idReceiver,
    this.idSender,
    this.idChat,
    this.status,
    this.url,
    this.isImage,
    this.isVideo,
    this.timestamp,
    this.controller
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    message: json["message"],
    idReceiver: json["id_receiver"],
    idSender: json["id_sender"],
    idChat: json["id_chat"],
    status: json["status"],
    url: json["url"],
    isImage: json["is_image"],
    isVideo: json["is_video"],
    timestamp: int.parse(json["timestamp"]),
  );

  static List<Message> fromJsonList(List<dynamic> jsonList) {
    List<Message> toList = [];

    jsonList.forEach((item) {
      Message message = Message.fromJson(item);
      toList.add(message);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "id_receiver": idReceiver,
    "id_sender": idSender,
    "id_chat": idChat,
    "status": status,
    "url": url,
    "is_image": isImage,
    "is_video": isVideo,
    "timestamp": timestamp,
  };
}
