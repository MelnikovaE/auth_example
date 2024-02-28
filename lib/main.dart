import 'package:auth_example/core/colors.dart';
import 'package:auth_example/core/internet_cubit.dart';
import 'package:auth_example/core/style_text.dart';
import 'package:auth_example/presentation/pages/autorization/authorization_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ConnectionCubit(),
        child: BlocListener<ConnectionCubit, MyConnectionState>(
            listener: (context, state) {
              if (state == MyConnectionState(connected: false)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "No internet connection",
                    style: MyStyleText.mediumlLine_14(white),
                  ),
                  backgroundColor: gray,
                ));
              }
            },
            child:  AuthorizationPage()),
      ),
    );
  }
}
