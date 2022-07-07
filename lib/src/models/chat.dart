import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {

  String? id;
  String? idUser1;
  String? idUser2;
  int? timestamp;

  // USUARIO 1
  String? nameUser1;
  String? lastnameUser1;
  String? emailUser1;
  String? phoneUser1;
  String? imageUser1;
  String? notificationTokenUser1;

  // USUARIO 2
  String? nameUser2;
  String? lastnameUser2;
  String? emailUser2;
  String? phoneUser2;
  String? imageUser2;
  String? notificationTokenUser2;

  String? lastMessage;
  int? unreadMessage;
  int? lastMessageTimestamp;

  Chat({
    this.id,
    this.idUser1,
    this.idUser2,
    this.timestamp,
    // USUARIO 1
    this.nameUser1,
    this.lastnameUser1,
    this.emailUser1,
    this.phoneUser1,
    this.imageUser1,
    this.notificationTokenUser1,
    // USUARIO 2
    this.nameUser2,
    this.lastnameUser2,
    this.emailUser2,
    this.phoneUser2,
    this.imageUser2,
    this.notificationTokenUser2,

    this.lastMessage,
    this.unreadMessage,
    this.lastMessageTimestamp,

  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    idUser1: json["id_user1"],
    idUser2: json["id_user2"],
    timestamp: int.parse(json["timestamp"]),
    // USUARIO 1
    nameUser1: json["name_user1"],
    lastnameUser1: json["lastname_user1"],
    emailUser1: json["email_user1"],
    phoneUser1: json["phone_user1"],
    imageUser1: json["image_user1"],
    notificationTokenUser1: json["notification_token_user1"],

    // USUARIO 2
    nameUser2: json["name_user2"],
    lastnameUser2: json["lastname_user2"],
    emailUser2: json["email_user2"],
    phoneUser2: json["phone_user2"],
    imageUser2: json["image_user2"],
    notificationTokenUser2: json["notification_token_user2"],

    lastMessage: json["last_message"],
    unreadMessage: json["unread_message"] != null ? int.parse(json["unread_message"]) : 0,
    lastMessageTimestamp: json["last_message_timestamp"] != null ? int.parse(json["last_message_timestamp"]) : 0,

  );

  static List<Chat> fromJsonList(List<dynamic> jsonList) {
    List<Chat> toList = [];

    jsonList.forEach((item) {
      Chat chat = Chat.fromJson(item);
      toList.add(chat);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user1": idUser1,
    "id_user2": idUser2,
    "timestamp": timestamp,
    // USUARIO 1
    "name_user1": nameUser1,
    "lastname_user1": lastnameUser1,
    "email_user1": emailUser1,
    "phone_user1": phoneUser1,
    "image_user1": imageUser1,
    // USUARIO 2
    "name_user2": nameUser2,
    "lastname_user2": lastnameUser2,
    "email_user2": emailUser2,
    "phone_user2": phoneUser2,
    "image_user2": imageUser2,
    "last_message": lastMessage,
    "unread_message": unreadMessage,
    "last_message_timestamp": lastMessageTimestamp,
    "notification_token_user1": notificationTokenUser1,
    "notification_token_user2": notificationTokenUser2,
  };
}
