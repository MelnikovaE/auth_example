import 'package:auth_example/core/colors.dart';
import 'package:flutter/material.dart';

class DialogWindow {
  static Future<void> showSnackBar(
    BuildContext context,
    String message,
  ) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: black.withOpacity(0.4),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      barrierColor: lightGray.withOpacity(0.3),
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: gray,
          ),
        );
      },
    );
  }
}