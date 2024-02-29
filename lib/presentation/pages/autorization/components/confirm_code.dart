import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:flutter/material.dart';

class ConfirmCode extends StatefulWidget {
  const ConfirmCode({super.key});

  @override
  State<ConfirmCode> createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  final List<FocusNode> _listFocusNodes =
      List.generate(6, (index) => FocusNode());

  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "Enter the confirmation code that was sent to your email: ПОЧТА",
              softWrap: true,
              textAlign: TextAlign.center,
              style: MyStyleText.mediumlLine_14(lightRed),
            ),
            const SizedBox(height: 25),
            
            //Поля ввода кода
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < 6; i++)
                  codeInputField(context, _listFocusNodes[i],
                      i != 5 ? _listFocusNodes[i + 1] : null)
              ],
            ),
            const SizedBox(height: 25),

            //Отправка кода
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: lightRed, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Confirm Authorization",
                  style: MyStyleText.mediumlLine_14(white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget codeInputField(BuildContext context, FocusNode focusNode,
          FocusNode? nextfocusNode) =>
      Container(
        width: 30,
        height: 50,
        decoration: BoxDecoration(
          color: whiteContainer,
          border: Border.all(color: gray, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(
              () {
                code = code + value;
                if (value.isNotEmpty && focusNode != null) {
                  FocusScope.of(context).requestFocus(nextfocusNode);
                }
              },
            );
          },
        ),
      );
}
