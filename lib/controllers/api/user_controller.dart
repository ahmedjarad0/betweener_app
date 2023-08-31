import 'package:betweener_app/core/helper/shared_pref.dart';
import 'package:betweener_app/models/user.dart';

Future<UserAuth> getUser() async {
  return userAuthFromJson(await SharedPerfController().getKey(PerfKeys.user.name)!);
}
