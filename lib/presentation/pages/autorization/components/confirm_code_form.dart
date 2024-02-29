import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:auth_example/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authorization_bloc/authorization_bloc.dart';

class ConfirmCodeForm extends StatefulWidget {
  final String email;
  const ConfirmCodeForm({super.key, required this.email});

  @override
  State<ConfirmCodeForm> createState() => _ConfirmCodeFormState();
}

class _ConfirmCodeFormState extends State<ConfirmCodeForm> {
  final List<FocusNode> _listFocusNodes =
      List.generate(6, (index) => FocusNode());

  String code = '';

  @override
  Widget build(BuildContext context) {
    final AuthorizationBloc bloc = BlocProvider.of<AuthorizationBloc>(context);
    return Column(
      children: [
        Text(
          "Enter the confirmation code that was \n sent to your email",
          softWrap: true,
          textAlign: TextAlign.center,
          style: MyStyleText.mediumlLine_14(lightRed),
        ),
        const SizedBox(height: 45),

        //Поля ввода кода
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < 6; i++)
              codeInputField(context, _listFocusNodes[i],
                  i != 5 ? _listFocusNodes[i + 1] : null)
          ],
        ),
        const SizedBox(height: 45),

        //Кнопка отправки кода
        CustomButton(
            text: "Confirm Authorization",
            function: () {
              if (code.length < 6) return;
              bloc.add(
                  ConfirmCodeEvent(email: widget.email, code: int.parse(code)));
            }),
        const SizedBox(height: 10),
      ],
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
          style: MyStyleText.normalLine_14(darkGray),
          cursorColor: darkGray,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(
              () {
                code = code + value;
                if (value.isNotEmpty && nextfocusNode != null) {
                  FocusScope.of(context).requestFocus(nextfocusNode);
                }
              },
            );
          },
        ),
      );
}
