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

      //Вход авторизованного пользователя в систему
      String? jsonJwt = prefs.getString(event.email);
      if (jsonJwt != null) {
        DateTime time = DateTime.parse(jsonDecode(jsonJwt)['time']);
        String jwt = jsonDecode(jsonJwt)['jwt'];

        //проверяем актуальность токена, если истек запрашиваем новый
        if (DateTime.now().isAfter(time)) {
          final newJsonJwt =
              await _apiRepository.refreshToken(jsonDecode(jsonJwt)['jwt']);
          jwt = jsonDecode(newJsonJwt)['jwt'];
          await prefs.setString(
            event.email,
            jsonEncode({
              'jwt': jwt,
              'time': DateTime.now().add(const Duration(hours: 1))
            }),
          );
        }

        //входим в систему
        final jsonId = await _apiRepository.getUserId("Bearer $jwt");
        emit(SuccessLoginState(id: jsonDecode(jsonId)['user_id']));
      }
      //Отправдка почты для получение кода регистрации
      else {
        try {
          await _apiRepository.sendVerificationCode({"email": event.email});
          emit(SuccessSendingEmailState(email: event.email));
        } catch (e) {
          log(e.toString());
          emit(ErrorState(
              text: "Во время отправки кода-подтверждения произошла ошибка"));
        }
      }
      // try {
      //   //получение ID авторизованного пользователя
      //   String? jsonJwt = prefs.getString(event.email);
      //   DateTime time = DateTime.parse(jsonDecode(jsonJwt!)['time']);
      //   String jwt = jsonDecode(jsonJwt)['jwt'];
      //   //проверяем актуальность токена, если истек запрашиваем новый
      //   if (DateTime.now().isAfter(time)) {
      //     final newJsonJwt =
      //         await _apiRepository.refreshToken(jsonDecode(jsonJwt)['jwt']);
      //     jwt = jsonDecode(newJsonJwt)['jwt'];
      //     await prefs.setString(
      //         event.email,
      //         jsonEncode({
      //           'jwt': jwt,
      //           'time': DateTime.now().add(const Duration(hours: 1))
      //         }));
      //   }
      //   //входим в систему
      //   final jsonId = await _apiRepository.getUserId("Bearer $jwt");
      //   emit(SuccessLoginState(id: jsonDecode(jsonId)['user_id']));
      // } catch (e) {
      //   //Отправдка почты для получение кода регистрации
      //   try {
      //     await _apiRepository.sendVerificationCode({"email": event.email});
      //     emit(SuccessSendingEmailState(email: event.email));
      //   } catch (e) {
      //     log(e.toString());
      //     emit(ErrorState(
      //         text: "Во время отправки кода-подтверждения произошла ошибка"));
      //   }
      // }
    });

    //Отправка кода
    on<ConfirmCodeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      emit(SendingState());
      try {
        final newJsonJwt =
            await _apiRepository.confirmCode(event.email, event.code);
        final jwt = jsonDecode(newJsonJwt)['jwt'];
        await prefs.setString(
            event.email,
            jsonEncode({
              'jwt': jwt,
              'time': (DateTime.now().add(const Duration(hours: 1)).toString())
            }));

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
