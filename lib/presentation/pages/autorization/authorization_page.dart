import 'package:auth_example/data/repository/api_repository.dart';
import 'package:auth_example/presentation/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:auth_example/presentation/pages/autorization/components/login_form.dart';
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
                    if (state is SendingEmailState) {
                      DialogWindow.showProgressBar(context);
                    }
                    if (state is SuccessSendingEmailState) {
                      Navigator.pop(context);                      
                      //Navigator.push(context, MaterialPageRoute(builder: ))
                      //DialogWindow.showSnackBar(context,"Код-подтверждение был отправлен на вашу почту");
                    }
                    if (state is ErrorSendingEmailState) {
                      Navigator.pop(context);
                      DialogWindow.showSnackBar(context,
                          "Во время отправки кода-подтверждения произошла ошибка");
                    }
                  },
                  child: const LoginForm()),
            ),
          )),
    );
  }
}
