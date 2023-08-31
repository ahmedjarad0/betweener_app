import 'dart:convert';
import 'dart:io';

import 'package:betweener_app/controllers/api/links_api_controller.dart';
import 'package:betweener_app/models/links.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../controllers/pref/shared_pref.dart';
import '../core/util/constants.dart';
import '../models/api_response.dart';
import '../models/user.dart';

class LinkProvider extends ChangeNotifier {
  final LinksApiController _linksApiController = LinksApiController();
  late List<Links> link = <Links>[];
  bool loading = false;

  Future<void> fetchLink(context) async {
    loading = true;
    notifyListeners();
    link = await _linksApiController.getLinks(context);
    loading = false;
    notifyListeners();
  }

  Future<ApiResponse> addLinks(Map<String, dynamic> body) async {
    UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(linksUrl.replaceFirst('/{id}', ''));
    var response = await http.post(uri, body: body, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Links links = Links.fromJson(jsonResponse['link']);
      link.add(links);
      notifyListeners();
      return ApiResponse('Added Successfully', true);
    }
    return ApiResponse('Something went error', false);
  }

  Future<ApiResponse> deletedLinks(int index) async {
    ApiResponse apiResponse =
        await _linksApiController.deleteLinks(id: index.toString());
    if (apiResponse.success) {
      link.removeAt(index);

      notifyListeners();
    }
    return apiResponse;
  }

  Future<ApiResponse> editLinks(Links linked, Map<String, dynamic> body) async {
    ApiResponse apiResponse =
        await _linksApiController.editLinks(id: linked.id.toString(), body: body);

     if(apiResponse.success){
      int index =  link.indexWhere((element) => element.id == linked.id);
      if(index!=-1){
        // link[index] =id as Links ;
        notifyListeners() ;
      }
     }
    return apiResponse ;

  }
}
