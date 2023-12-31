import 'dart:convert';
import 'package:betweener_app/core/helper/shared_pref.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/models/user.dart';
import 'package:http/http.dart' as http;

import '../../core/util/constants.dart';

class AuthApiController {
  Future<ApiHelper> login(String email, String password) async {
    Uri uri = Uri.parse(loginUrl);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      UserAuth userAuth = UserAuth.fromJson(jsonResponse);
      SharedPerfController().save(userAuth);
      return ApiHelper('Login Successfully ', true);
    }
    return ApiHelper('Something went error ,try again ', false);
  }

  Future<ApiHelper> register(Map<String, String> body) async {
    Uri uri = Uri.parse(registerUrl);
    var response = await http.post(uri, body: body);
    // print(response.body);
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);

      UserAuth userAuth = UserAuth.fromJson(jsonResponse);
      SharedPerfController().save(userAuth);

      return ApiHelper('Register Successfully ', true);
    }
    return ApiHelper('Something went error ,try again ', false);
  }
}
