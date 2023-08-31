import 'dart:convert';
import 'dart:io';
import 'package:betweener_app/core/helper/shared_pref.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/models/links.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/pages/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../core/util/constants.dart';

class LinksApiController {
  Future<List<Links>> getLinks(context) async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(linksUrl.replaceFirst('/{id}', ''));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['links'] as List;
      return jsonArray.map((jsonObject) => Links.fromJson(jsonObject)).toList();
    }
    if (response.statusCode == 401) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
    return [];
  }

  Future<ApiHelper> addLinks(Map<String, dynamic> body) async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(linksUrl.replaceFirst('/{id}', ''));
    var response = await http.post(uri, body: body, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Links links = Links.fromJson(jsonResponse['link']);
      return ApiHelper('Added Successfully', true);
    }
    return ApiHelper('Something went error', false);
  }

  Future<ApiHelper> editLinks(
      {required String id, required Map<String, dynamic> body}) async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(linksUrl.replaceFirst('{id}', id.toString()));
    var response = await http.put(uri, body: body, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiHelper(jsonResponse['message'], true);
    }
    return ApiHelper('Something went error !', false);
  }

  Future<ApiHelper> deleteLinks({required String id}) async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(linksUrl.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
      HttpHeaders.acceptHeader: 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiHelper(jsonResponse['message'], true);
    }
    return ApiHelper('Something went error', false);
  }
}
