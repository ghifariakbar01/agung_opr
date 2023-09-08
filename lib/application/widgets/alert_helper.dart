import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class AlertHelper {
  static void showSnackBar(BuildContext context, {required String message}) {
    showFlash(
      context: context,
      barrierDismissible: true,
      persistent: true,
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: FlashPosition.bottom,
          behavior: FlashBehavior.floating,
          content: Text(message),
        );
      },
    );
  }
}
