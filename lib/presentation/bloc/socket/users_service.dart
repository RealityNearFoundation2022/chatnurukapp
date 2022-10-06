import 'package:http/http.dart' as http;

import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/core/helper/url_constants.dart';
// import 'package:reality_near/global/environment.dart';
import '../../../data/models/usersResponseModel.dart';

class UsersService {
  Future<List<UsersConnected>> getUsers() async {
    try {
      String token = await getPersistData("userToken");
      final String baseUrl = CHAT_NURUK + "users";
      final url = baseUrl;
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'token': token,
      });
      final usersResponse = usersResponseFromJson(response.body);
      return usersResponse.usersConnected;
    } catch (e) {
      return [];
    }
  }
}
