part of 'authorization_bloc.dart';

@immutable
sealed class AuthorizationEvent {}

class SendEmailEvent extends AuthorizationEvent{
  final String email;

  SendEmailEvent({required this.email});
}

class ConfirmCodeEvent extends AuthorizationEvent{
  final String email;
  final int code;

  ConfirmCodeEvent({required this.code, required this.email});
}
