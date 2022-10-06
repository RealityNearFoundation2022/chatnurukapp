// To parse this JSON data, do
// final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    this.ok,
    this.messages,
  });

  bool ok;
  List<Message> messages;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        ok: json["ok"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.myId,
    this.messagesTo,
    this.message,
    this.createAt,
    this.updatedAt,
  });

  String myId;
  String messagesTo;
  String message;
  DateTime createAt;
  DateTime updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        myId: json["myId"],
        messagesTo: json["messagesTo"],
        message: json["message"],
        createAt: DateTime.parse(json["createAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "myId": myId,
        "messagesTo": messagesTo,
        "message": message,
        "createAt": createAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
