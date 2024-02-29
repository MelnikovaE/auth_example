import 'package:auth_example/core/colors.dart';
import 'package:auth_example/data/repository/api_repository.dart';
import 'package:auth_example/presentation/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:auth_example/presentation/pages/autorization/components/confirm_code_form.dart';
import 'package:auth_example/presentation/pages/autorization/components/login_form.dart';
import 'package:auth_example/presentation/pages/autorization/components/top_of_auth_page.dart';
import 'package:auth_example/presentation/pages/home/home_page.dart';
import 'package:auth_example/presentation/widgets/dialog_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({super.key});
  final ApiRepository _apiRepository = ApiRepository();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => AuthorizationBloc(_apiRepository),
            child: BlocListener<AuthorizationBloc, AuthorizationState>(
              listener: (context, state) {
                //Состояние отправки
                if (state is SendingState) {
                  DialogWindow.showProgressBar(context);
                } else {
                  Navigator.pop(context);
                  //Успешный вход в систему
                  if (state is SuccessLoginState) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (HomePage(id: state.id))));
                  }
                  //Состояние ошибки при отправки
                  if (state is ErrorState) {
                    DialogWindow.showSnackBar(context, state.text);
                  }
                }

              },
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
                      //Верхняя шапка экрана
                      const TopOfAuthPage(),

                      //Сколькозящая поверхность
                      BlocBuilder<AuthorizationBloc, AuthorizationState>(
                        builder: (context, state) {
                          //нужно продумать механиз при других состояниях
                          if (state is SuccessSendingEmailState) {
                            return ConfirmCodeForm(email: state.email);
                          } else {
                            return const LoginForm();
                          }
                          //
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
