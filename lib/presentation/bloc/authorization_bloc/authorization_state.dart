part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationState {}

final class AuthorizationInitialState extends AuthorizationState {}

//Момент отправки почты
final class SendingEmailState extends AuthorizationState {}

//Успешная отправка почты
final class SuccessSendingEmailState extends AuthorizationState {}

//Ошибка при отправке почты
final class ErrorSendingEmailState extends AuthorizationState {}