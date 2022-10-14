// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.ok,
    this.messages,
  });

  bool ok;
  List<Message> messages;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
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
    this.from,
    this.to,
    this.message,
    this.createAt,
    this.updatedAt,
  });

  String from;
  String to;
  String message;
  DateTime createAt;
  DateTime updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createAt: DateTime.parse(json["createAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createAt": createAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
