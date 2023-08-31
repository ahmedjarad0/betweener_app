import 'package:flutter/material.dart';

import 'constants.dart';

abstract class Styles {
  static OutlineInputBorder primaryRoundedOutlineInputBorder =
  OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: kPrimaryColor,
      width: 2,
    ),
  );
  static OutlineInputBorder errorRoundedOutlineInputBorder =
  OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: kRedColor,
      width: 2,
    ),
  );
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: kPrimaryColor,
  );
}