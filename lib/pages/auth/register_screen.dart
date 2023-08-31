import 'package:betweener_app/controllers/api/auth_api_controller.dart';
import 'package:betweener_app/core/util/constants.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/pages/loading/loading_screen.dart';
import 'package:betweener_app/pages/widgets/custom_text_form_field.dart';
import 'package:betweener_app/pages/widgets/secondary_button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/helper/snak_bar.dart';
import '../widgets/primary_outlined_button_widget.dart';

class RegisterScreen extends StatefulWidget {
  static String id = '/register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helper {
  late TextEditingController _emailCtl;

  late TextEditingController _nameCtl;

  late TextEditingController _passwordCtl;

  late TextEditingController _rePasswordCtl;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailCtl = TextEditingController();
    _nameCtl = TextEditingController();
    _passwordCtl = TextEditingController();
    _rePasswordCtl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameCtl.dispose();
    _emailCtl.dispose();
    _passwordCtl.dispose();
    _rePasswordCtl.dispose();
    super.dispose();
  }

  void submitRegister() async {
    Map<String, String> body = {
      'name': _nameCtl.text,
      'email': _emailCtl.text,
      'password': _passwordCtl.text,
      'password_confirmation': _rePasswordCtl.text
    };
    if (_formKey.currentState!.validate()) {
      ApiResponse apiResponse = await AuthApiController().register(body);
      if (apiResponse.success && mounted) {
        Navigator.pushReplacementNamed(context, LoadingScreen.id);
      }
      snackBar(context,
          message: apiResponse.message, success: apiResponse.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  child: Hero(
                      tag: 'authImage',
                      child:
                          SvgPicture.asset(authImage, height: 92, width: 154)),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomTextFormField(
                    controller: _nameCtl,
                    autofillHints: const [AutofillHints.name],
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'please enter your name';
                      }
                    },
                    hintText: 'John Doe',
                    labelText: 'Name'),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _emailCtl,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                    hintText: 'Example@gmail.com',
                    labelText: 'Email'),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _passwordCtl,
                    autofillHints: const [AutofillHints.password],
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'please enter password';
                      } else if (v.length < 6) {
                        return 'password must contain at least 6 letters';
                      }
                    },
                    hintText: '********',
                    labelText: 'Password',
                    obscure: true),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _rePasswordCtl,
                    autofillHints: const [AutofillHints.password],
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'please enter password';
                      } else if (v.length < 6) {
                        return 'password must contain at least 6 letters';
                      }
                    },
                    hintText: '********',
                    labelText: 'Re-Password',
                    obscure: true),
                const SizedBox(
                  height: 45,
                ),
                SecondaryButtonWidget(
                  onTap: () {
                    submitRegister();
                  },
                  title: 'Register',
                  width: double.infinity,
                ),
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

              ]),
            ),
          ),
        ),
      ),
    );
  }
}
