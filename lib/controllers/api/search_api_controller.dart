import 'dart:convert';
import 'dart:io';
import 'package:betweener_app/core/helper/shared_pref.dart';
import 'package:betweener_app/core/util/constants.dart';
import 'package:betweener_app/models/user.dart';
import 'package:http/http.dart' as http;

class SearchApiController {
  Future<List<User>> searchName(String name) async {
    UserAuth userAuth =
        userAuthFromJson(SharedPerfController().getKey(PerfKeys.user.name));
    Uri uri = Uri.parse(searchUrl);
    var response = await http.post(uri,
        body: {'name': name},
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}'});
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['user'] as List;
      return jsonArray.map((jsonObject) => User.fromJson(jsonObject)).toList();
    }
    return [];
  }
}
