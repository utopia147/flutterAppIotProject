part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final bool rememberMe;
  LoginEvent(
    this.email,
    this.password,
    this.rememberMe,
  );
  @override
  String toString() =>
      "LoginEvent {email:$email , password:$password , remember me:$rememberMe}";
}

class CheckAuthenEvent extends AuthenticationEvent {
  @override
  String toString() => "Check Authen {}";
}

class CheckFormEvent extends AuthenticationEvent {
  final bool checkEmail;
  final bool checkPassword;
  CheckFormEvent(this.checkEmail, this.checkPassword);
  @override
  String toString() => "CheckFormEmailEvent{checkEmail:$checkEmail}";
}

class LogoutEvent extends AuthenticationEvent {
  @override
  String toString() => "Logout {}";
}

class AppIntro extends AuthenticationEvent {
  @override
  String toString() => "App Intro {}";
}
