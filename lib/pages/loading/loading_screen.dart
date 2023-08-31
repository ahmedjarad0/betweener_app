import 'package:betweener_app/core/helper/shared_pref.dart';
import 'package:betweener_app/pages/main/main_app_screen.dart';
import 'package:betweener_app/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../onboarding/on_boarding_screen.dart';
class LoadingScreen extends StatefulWidget {
  static String id = '/OnBoardingScreen_screen';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1),() {
       SharedPerfController().checkLogin(context);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(color: Colors.lightBlue,size: 20,),
      ),
    );
  }
}
