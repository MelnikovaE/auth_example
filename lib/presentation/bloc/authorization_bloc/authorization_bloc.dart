import 'dart:developer';
import 'dart:convert';

import 'package:auth_example/data/repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final ApiRepository _apiRepository;
  AuthorizationBloc(this._apiRepository) : super(AuthorizationInitialState()) {
    
    //Отправка почты
    on<SendEmailEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SendingState());
      try {
        //получение ID авторизованного пользователя
        final jwt = prefs.getString(event.email);
        final jsonId = await _apiRepository.getUserId("Bearer $jwt");
        emit(SuccessLoginState(id: jsonDecode(jsonId)['user_id']));
      } catch (e) {
        //Отправдка почты для получение кода регистрации
        try {
          await _apiRepository.sendVerificationCode({"email": event.email});
          emit(SuccessSendingEmailState(email: event.email));
        } catch (e) {
          log(e.toString());
          emit(ErrorState(
              text: "Во время отправки кода-подтверждения произошла ошибка"));
        }
      }
    });

    //Отправка кода
    on<ConfirmCodeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SendingState());
      try {
        final jsonJwt = await _apiRepository.confirmCode(event.email, event.code);
        final jwt = jsonDecode(jsonJwt)['jwt'];
        await prefs.setString(event.email, jwt);

        final jsonId = await _apiRepository.getUserId("Bearer $jwt");
        emit(SuccessLoginState(id: jsonDecode(jsonId)['user_id']));
      } catch (e) {
        log(e.toString());
        emit(ErrorState(
            text: "Во время подтвержения авторизации произошла ошибка"));
      }
    });
  }
}
