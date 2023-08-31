import 'package:betweener_app/controllers/api/links_api_controller.dart';
import 'package:betweener_app/controllers/api/user_controller.dart';
import 'package:betweener_app/models/api_response.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/pages/widgets/custom_text_form_field.dart';
import 'package:betweener_app/pages/widgets/secondary_button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  static String id = '/add_profile_screen';
   UserAuth ?userAuth ;
   EditProfileScreen({super.key, required this.userAuth});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameCtr;
  late TextEditingController _emailCtr;
  final _formKey = GlobalKey<FormState>();
  late UserAuth userAuth;

  @override
  void initState() {

    super.initState();
    _nameCtr = TextEditingController(text: widget.userAuth!.user!.name);
    _emailCtr = TextEditingController(text: widget.userAuth!.user!.email);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameCtr.dispose();
    _emailCtr.dispose();
    super.dispose();
  }
  UserAuth get user {
  UserAuth user = UserAuth();
  user.user!.name = _nameCtr.text;
  user.user!.email = _emailCtr.text;
  return user ;
  }
 void editProfile() async {
    if (_formKey.currentState!.validate()) {
     widget.userAuth = user ;
    Navigator.pop(context);

    }

  }

  @override
  Widget build(BuildContext context) {
    // final arg =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // _nameCtr.text = arg['name'];
    // _emailCtr.text = arg['email'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'John Doe',
                  labelText: 'name',
                  controller: _nameCtr,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'please enter name';
                    }
                  },
                ),
                const SizedBox(
                  height: 19,
                ),
                CustomTextFormField(
                    hintText: 'example@gmail.com',
                    labelText: 'email',
                    validator: (v) {
                      if (EmailValidator.validate(v!)) {
                        return null;
                      } else {
                        return 'please enter the email';
                      }
                    },
                    controller: _emailCtr),
                const SizedBox(
                  height: 41,
                ),
                SecondaryButtonWidget(
                    title: 'SAVE',
                    width: 138,
                    onTap: () {
                      editProfile();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
