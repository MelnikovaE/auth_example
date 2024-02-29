import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:flutter/material.dart';

class TopOfAuthPage extends StatelessWidget {
  const TopOfAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: MyStyleText.mediumlLine_18(),
            ),
            const Icon(Icons.person_rounded)
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Welcome back",
            style: MyStyleText.normalLine_14(gray),
          ),
        ),
        const SizedBox(height: 25),
        Image.asset(
          'assets/images/packOnlineShopping.png',
          height: height > 750 ? 280 : 130,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
