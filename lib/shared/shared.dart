import 'package:clinic_app/shared/colors.dart';
import 'package:flutter/material.dart';

class Shared {
  snackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: buttonColor.withOpacity(0.6),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
