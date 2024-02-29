import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/style_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() function;
  const CustomButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            color: lightRed, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: MyStyleText.mediumlLine_14(white),
        ),
      ),
    );
  }
}
