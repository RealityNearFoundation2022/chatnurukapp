import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
import 'package:reality_near/data/models/messageModel.dart';
// import 'package:reality_near/data/models/usersResponseModel.dart';
import 'package:reality_near/domain/entities/user.dart';

class ChatService with ChangeNotifier {
  User userTo;

  Future<List<Message>> getChat() async {
    String token = await getPersistData("userToken");
    const url = CHAT_NURUK_PROD + "messages";
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'token': token,
    });
    final messageResponse = messageResponseFromJson(response.body);
    return messageResponse.messages;
  }
}
