part of 'authorization_bloc.dart';

enum Status{sending,success,error}

@immutable
sealed class AuthorizationState {}

final class AuthorizationInitialState extends AuthorizationState {}

//В момент отправки почты
final class SendingEmailState extends AuthorizationState {
    final status = Status.sending;
}

//Успешная отправка почты
final class SuccessSendingEmailState extends AuthorizationState {
   final status = Status.success;
}

//Ошибка при отправке почты
final class ErrorSendingEmailState extends AuthorizationState {
  final status = Status.error;

}