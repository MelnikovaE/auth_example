import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String id;
  const HomePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
                  child: Text("You are logged in. Your ID: $id",
                  textAlign: TextAlign.center,
                  softWrap: true,style: MyStyleText.mediumlLine_18(gray),),
                ),
          )),
    );
  }
}
