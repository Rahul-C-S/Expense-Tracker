part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email, password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

final class LogoutEvent extends AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final String email, password;

  SignUpEvent({
    required this.email,
    required this.password,
  });
}
