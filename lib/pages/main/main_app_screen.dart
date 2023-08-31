import 'package:betweener_app/controllers/pref/shared_pref.dart';
import 'package:betweener_app/core/util/constants.dart';
import 'package:betweener_app/pages/auth/login_screen.dart';
import 'package:betweener_app/pages/home/home_screen.dart';
import 'package:betweener_app/pages/profile/profile_screen.dart';
import 'package:betweener_app/pages/receive/qr_screen.dart';
import 'package:betweener_app/pages/receive/receive_screen.dart';
import 'package:betweener_app/pages/search/search_screen.dart';
import 'package:betweener_app/pages/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_floating_nav_bar.dart';

class MainAppScreen extends StatefulWidget {
  static String id = '/main_app_screen';

  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 1;
  final List<Widget> _screens = const [
    ReceiveScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          if(_currentIndex == 1)
          IconButton(onPressed: () {
            Navigator.pushNamed(context, SearchScreen.id);
          }, icon: const Icon(Icons.search)),
          if(_currentIndex == 1)
            IconButton(onPressed: () {
              Navigator.pushNamed(context, QrScannerView.id);
            }, icon: const Icon(Icons.qr_code)),
          IconButton(
              onPressed: () async {
                await SharedPerfController().clean();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                }
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
