import 'package:betweener_app/core/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/login_screen.dart';
import '../widgets/secondary_button_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  static String id = '/onBoardingScreen';

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(
            flex: 2,
          ),
          Center(
              child: SvgPicture.asset(
            'assets/img/onboarding.svg',
            height: 251,
            width: 254,
          )),
          const SizedBox(
            height: 19,
          ),
          Text(
            'Just one Scan for everything',
            style: GoogleFonts.roboto(
                color: kPrimaryColor, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const Spacer(),
          // const SizedBox(
          //   height: 163,
          // ),
           SecondaryButtonWidget(
              title: 'Get Started', width: double.infinity, onTap: () {
            Navigator.pushReplacementNamed(context, LoginScreen.id);

          }),
          const Spacer(),
        ]),
      ),
    );
  }
}
