import 'package:demo/service/Constant.dart';
import 'package:http/http.dart' as http;

import '../Model/UserModel.dart';

class ApiService {
  Future<UserModel?> getUser() async {
    var url = Uri.parse(Constant.BaseURL + Constant.ApiEndPoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return userModelFromJson(response.body);
    } else {
      throw Exception("network error");
    }
  }
}
