
import 'package:betweener_app/controllers/api/links_api_controller.dart';
import 'package:betweener_app/core/helper/api_response.dart';
import 'package:betweener_app/models/links.dart';
import 'package:flutter/cupertino.dart';



class LinkProvider extends ChangeNotifier {
  final LinksApiController _linksApiController = LinksApiController();
  late ApiResponse<List<Links>> _link;

  ApiResponse<List<Links>> get links => _link;

  Future<void> fetchLink(context) async {
    _link = ApiResponse.loading('loading');
    notifyListeners();
    try {
      final repo = await _linksApiController.getLinks(context);
      _link = ApiResponse.completed(repo);
      notifyListeners();
    } catch (e) {
      _link = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

// Future<ApiHelper> addLinks(Map<String, dynamic> body) async {
//   UserAuth userAuth = userAuthFromJson(SharedPerfController().userAuth);
//   Uri uri = Uri.parse(linksUrl.replaceFirst('/{id}', ''));
//   var response = await http.post(uri, body: body, headers: {
//     HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
//   });
//   if (response.statusCode == 200) {
//     var jsonResponse = jsonDecode(response.body);
//     Links links = Links.fromJson(jsonResponse['link']);
//     link.add(links);
//     notifyListeners();
//     return ApiHelper('Added Successfully', true);
//   }
//   return ApiHelper('Something went error', false);
// }

// Future<ApiHelper> deletedLinks(int index) async {
//   ApiHelper apiResponse =
//       await _linksApiController.deleteLinks(id: index.toString());
//   if (apiResponse.success) {
//     link.removeAt(index);
//
//     notifyListeners();
//   }
//   return apiResponse;
// }

// Future<ApiHelper> editLinks(Links linked, Map<String, dynamic> body) async {
//   ApiHelper apiResponse =
//       await _linksApiController.editLinks(id: linked.id.toString(), body: body);
//
//    if(apiResponse.success){
//     int index =  link.indexWhere((element) => element.id == linked.id);
//     if(index!=-1){
//       // link[index] =id as Links ;
//       notifyListeners() ;
//     }
//    }
//   return apiResponse ;
//
// }
}
