part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationEvent {}

//class OpenLoginFormEvent extends AuthorizationEvent{}

//Отправка почты
class SendEmailEvent extends AuthorizationEvent{
  final String email;

  SendEmailEvent({required this.email});
}

//Отправка кода подтверждения
class ConfirmCodeEvent extends AuthorizationEvent{
  final String email;
  final int code;

  ConfirmCodeEvent({required this.code, required this.email});
}
