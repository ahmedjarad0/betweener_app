import 'package:flutter/material.dart';

mixin Helper {
  void snackBar(BuildContext context,
      {required String message, bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green.shade500 : Colors.red.shade500,
    ));
  }
}
