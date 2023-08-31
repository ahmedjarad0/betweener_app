import 'package:betweener_app/controllers/api/auth_api_controller.dart';
import 'package:betweener_app/controllers/api/links_api_controller.dart';
import 'package:betweener_app/core/helper/snak_bar.dart';
import 'package:betweener_app/models/links.dart';
import 'package:betweener_app/pages/auth/register_screen.dart';
import 'package:betweener_app/pages/loading/loading_screen.dart';
import 'package:betweener_app/pages/main/main_app_screen.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/pages/onboarding/on_boarding_screen.dart';
import 'package:betweener_app/pages/widgets/custom_text_form_field.dart';
import 'package:betweener_app/pages/widgets/secondary_button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/util/constants.dart';
import '../widgets/primary_outlined_button_widget.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper {
  late TextEditingController _emailCtl;
  bool _obscure = true ;
  late TextEditingController _passwordCtl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailCtl = TextEditingController();
    _passwordCtl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState!.validate()) {
      ApiHelper apiResponse =
          await AuthApiController().login(_emailCtl.text, _passwordCtl.text);
      if (apiResponse.success) {
        Navigator.pushReplacementNamed(context, LoadingScreen.id);
      }
      snackBar(context,
          message: apiResponse.message, success: apiResponse.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SafeArea(
                child: Column(children: [
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Hero(
                          tag: 'authImage',
                          child: SvgPicture.asset(
                            'assets/img/auth.svg',
                          ))),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextFormField(
                    controller: _emailCtl,
                    validator: (String ?value) {
                      if (EmailValidator.validate(value!)) {
                          return null ;

                    }else {
                        return 'please enter the email';
                      }},
                    hintText: 'example@gmail.com',
                    labelText: 'Email',
                    autofillHints: const [AutofillHints.email],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: _passwordCtl,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'please enter password';
                      } else if (v.length < 6) {
                        return 'password must contain at least 6 letters';
                      }
                    },
                    hintText: '*******',
                    labelText: 'Password',
                    obscure: _obscure,
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscure = !_obscure;

                      });
                    }, icon: _obscure ?const Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined)),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SecondaryButtonWidget(
                      title: 'LOGIN',
                      width: double.infinity,
                      onTap: () {
                        login();
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  PrimaryOutlinedButtonWidget(
                      text: 'Register',
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      }),
                  const SizedBox(
                    height: 19,
                  ),
                  Text(
                    '-    or    -',
                    style: GoogleFonts.roboto(
                        color: kHintTextFieldColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  PrimaryOutlinedButtonWidget(
                    text: 'SIGN IN WITH GOOGLE',
                    onTap: () {},
                    color: kRedColor,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
