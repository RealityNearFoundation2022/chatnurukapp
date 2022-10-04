// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
    this.ok,
    this.usersConnected,
  });

  bool ok;
  List<UsersConnected> usersConnected;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        usersConnected: List<UsersConnected>.from(
            json["usersConnected"].map((x) => UsersConnected.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usersConnected":
            List<dynamic>.from(usersConnected.map((x) => x.toJson())),
      };
}

class UsersConnected {
  UsersConnected({
    this.online,
    this.iduser,
    this.uid,
  });

  bool online;
  String iduser;
  String uid;

  factory UsersConnected.fromJson(Map<String, dynamic> json) => UsersConnected(
        online: json["online"],
        iduser: json["_iduser"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "_iduser": iduser,
        "uid": uid,
      };
}
