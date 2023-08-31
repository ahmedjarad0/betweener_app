import 'package:betweener_app/core/util/style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/util/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.onChanged,
    this.obscure = false,
    required this.hintText,
    required this.labelText,
    this.autofillHints,
    this.controller,
    this.validator,
    this.suffixIcon,
    super.key,
  });

  final String hintText;
  final TextEditingController? controller;

  final String labelText;
  final String? Function(String?)? validator;
  final bool obscure;
  final Widget? suffixIcon;
  final Iterable<String>? autofillHints;
 final  Function(String)? onChanged ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Styles.textStyle14,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(

            obscureText: obscure,
            validator: validator,
            controller: controller,
             onChanged: (value) {

             },
            autofillHints: autofillHints,
            autocorrect: obscure == true ? false : true,
            enableSuggestions: obscure == true ? false : true,
            decoration: InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always,

        suffixIcon:suffixIcon ,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(color: kHintTextFieldColor,fontSize: 12,fontWeight: FontWeight.w500),

              border: Styles.primaryRoundedOutlineInputBorder,
              focusedBorder: Styles.primaryRoundedOutlineInputBorder,
              disabledBorder: Styles.primaryRoundedOutlineInputBorder,
              enabledBorder: Styles.primaryRoundedOutlineInputBorder,
              errorBorder: Styles.errorRoundedOutlineInputBorder,
            )),
      ],
    );
  }
}
