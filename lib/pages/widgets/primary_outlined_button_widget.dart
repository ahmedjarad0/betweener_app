import 'package:flutter/material.dart';
import '../../core/util/constants.dart';
class PrimaryOutlinedButtonWidget extends StatelessWidget {
  const PrimaryOutlinedButtonWidget({
    required this.text ,
    required this.onTap ,
    this.color = kPrimaryColor ,
    this.icon ,
    super.key,
  });
 final String text ;
 final Function () onTap ;
 final Color color ;
 final Widget ? icon ;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          side:  BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                side:  const BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(12))),
        child:


            Text(
              text,
              style:  TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: color),


        ),
      ),
    );
  }
}
