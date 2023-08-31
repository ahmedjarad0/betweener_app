import 'package:betweener_app/controllers/pref/shared_pref.dart';
import 'package:betweener_app/pages/auth/register_screen.dart';
import 'package:betweener_app/pages/follow/following_screen.dart';
import 'package:betweener_app/pages/home/home_screen.dart';
import 'package:betweener_app/pages/link/add_link_screen.dart';
import 'package:betweener_app/pages/link/edit_link_screen.dart';
import 'package:betweener_app/pages/main/main_app_screen.dart';
import 'package:betweener_app/pages/auth/login_screen.dart';
import 'package:betweener_app/pages/loading/loading_screen.dart';
import 'package:betweener_app/pages/onboarding/on_boarding_screen.dart';
import 'package:betweener_app/pages/profile/edit_profile_screen.dart';
import 'package:betweener_app/pages/profile/profile_screen.dart';
import 'package:betweener_app/pages/receive/qr_screen.dart';
import 'package:betweener_app/pages/receive/receive_screen.dart';
import 'package:betweener_app/pages/search/search_screen.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/util/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPerfController().initPerf();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LinkProvider>(create: (context) => LinkProvider(),),
      ],
    builder: (context, child) {
      return  MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: kPrimaryColor,
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              elevation: 0,
              titleTextStyle: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            scaffoldBackgroundColor: kScaffoldColor),
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingScreen.id,
        routes: {
          LoadingScreen.id: (context) => const LoadingScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          OnBoardingScreen.id: (context) => const OnBoardingScreen(),
          MainAppScreen.id: (context) => const MainAppScreen(),
          ReceiveScreen.id: (context) => const ReceiveScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          AddLinkScreen.id: (context) => const AddLinkScreen(),
          EditLinkScreen.id: (context) => const EditLinkScreen(),
          SearchScreen.id: (context) => const SearchScreen(),
          QrScannerView.id: (context) => const QrScannerView(),
        },
      );
    },
    );
  }
}
