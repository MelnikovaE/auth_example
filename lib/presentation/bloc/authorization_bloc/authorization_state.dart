part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationInitialState extends AuthorizationState {}

//В момент отправки запроса
final class SendingState extends AuthorizationState {}

//Успешный вход в аккаунт 
final class SuccessLoginState extends AuthorizationState {
  final String id;
  SuccessLoginState({required this.id});
}

//Успешная отправка почты для авторизации
final class SuccessSendingEmailState extends AuthorizationState {
  final String email;
  SuccessSendingEmailState({required this.email});
}

//Ошибка при отправке/подтверждении
final class ErrorState extends AuthorizationState {
  final String text;
  ErrorState({required this.text});
}
