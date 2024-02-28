import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const MyTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: MyStyleText.normalLine_14(darkGray),
      cursorColor: darkGray,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Please enter valid number!'
          : null,
      decoration: InputDecoration(
        enabledBorder: customBorder(Colors.transparent),
        focusedBorder: customBorder(Colors.transparent),
        errorBorder: customBorder(lightRed),
        focusedErrorBorder: customBorder(lightRed),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: MyStyleText.normalLine_14(darkGray)
      ),
    );
  }
}

OutlineInputBorder customBorder(Color color) => OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10),
    );
