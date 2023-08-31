import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
class SecondaryButtonWidget extends StatelessWidget {
  const SecondaryButtonWidget({
    required this.title ,
    required this.width ,
    required this.onTap ,
    super.key,
  });
final  String title ;
 final double width ;
 final Function ()onTap ;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(autofocus: true,
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize:  Size(width, 50),
          backgroundColor: kSecondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12))),
      child:  Text(
        title,
        style: const TextStyle(
            color: kOnSecondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
    );
  }
}
