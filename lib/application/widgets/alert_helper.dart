import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static void showSnackBar(BuildContext context, {required String message}) {
    showFlash(
      context: context,
      persistent: true,
      barrierDismissible: true,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: FlashPosition.top,
          behavior: FlashBehavior.floating,
          content: Text(message),
        );
      },
    );
  }
}
