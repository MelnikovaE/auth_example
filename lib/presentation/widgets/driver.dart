import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:flutter/material.dart';

Widget customDivider(String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          const Expanded(
              child: Divider(
            thickness: 1,
            color: grayDivider,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: MyStyleText.normalLine_12(lightGray),
            ),
          ),
          const Expanded(
              child: Divider(
            thickness: 1,
            color: grayDivider,
          )),
        ],
      ),
    );
