import 'dart:convert';
import 'dart:io';

import 'package:betweener_app/core/util/constants.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/models/follow.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../pref/shared_pref.dart';

class FollowApiController {
  Future<Follow> getFollow() async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);

    Uri uri = Uri.parse(followUrl);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return followFromJson(response.body);
    }
    return Future.error('Something error');
  }

  Future<ApiResponse> addFollow(Map<String, dynamic> body) async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);

    Uri uri = Uri.parse(followUrl);
    var response = await http.post(uri, body: body, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return ApiResponse('Operation Successfully', true);
    }
    return ApiResponse('Something error', false);
  }
}
