import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:auth_example/presentation/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:auth_example/presentation/widgets/button.dart';
import 'package:auth_example/presentation/widgets/driver.dart';
import 'package:auth_example/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthorizationBloc bloc = BlocProvider.of<AuthorizationBloc>(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Enter Your Email",
            softWrap: true,
            textAlign: TextAlign.center,
            style: MyStyleText.mediumlLine_18(lightRed),
          ),
          const SizedBox(height: 25),

          //Поле ввода
          CustomTextFormField(
              controller: _emailController, hintText: "Enter Email"),
          const SizedBox(height: 10),

          //Кнопка смены почты
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Change Email ?",
                  style: MyStyleText.normalLine_12(lightBlack),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          //Кнопка авторизации
          CustomButton(text: "Login",function: (){
            final isValid = _formKey.currentState!.validate();
              if (!isValid) return;
              bloc.add(SendEmailEvent(email: _emailController.text));
          }),
          const SizedBox(height: 40),

          //Разделитель
          customDivider("Or Login with"),
          const SizedBox(height: 25),

          //Кнопка авторизации через почту Google
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/googleLogo.png',
                    height: 30,
                  ),
                  Text(
                    "Google",
                    style: MyStyleText.mediumlLine_14(),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),

          //Переход к регистрации
          GestureDetector(
            onTap: () {},
            child: RichText(
              text: TextSpan(
                text: "You Don't have an account? ",
                style: MyStyleText.normalLine_12(),
                children: [
                  TextSpan(
                      text: "Sing Up", style: MyStyleText.mediumLine_12())
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
