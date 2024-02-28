import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:auth_example/presentation/bloc/authorization_bloc/authorization_bloc.dart';
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
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: whiteContainer,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                'images/packOnlineShopping.png',
                height: height > 750 ? 280 : 130,
              ),
              const SizedBox(height: 15),

              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Enter Your Email",
                    style: MyStyleText.mediumlLine_18(lightRed),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              //Поле ввода
              MyTextFormField(
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
              InkWell(
                onTap: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) return;
                  bloc.add(SendEmailEvent(email: _emailController.text));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: lightRed, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Login",
                    style: MyStyleText.mediumlLine_14(white),
                  ),
                ),
              ),
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
                        'images/googleLogo.png',
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
        ),
      ),
    );
  }
}
