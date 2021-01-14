part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class LoginSucessState extends AuthenticationState {}

class LoginFailedState extends AuthenticationState {
  var res;
  LoginFailedState(this.res);
}

class ErrorAuthenState extends AuthenticationState {
  final String msg;
  ErrorAuthenState(this.msg);
}

class CheckFormState extends AuthenticationState {
  final bool checkEmailState;
  final bool checkPasswordState;
  CheckFormState(this.checkEmailState, this.checkPasswordState);
  @override
  String toString() =>
      "checkFormState{checkEmailState:$checkEmailState,checkPasswordState:$checkPasswordState}";
}

class LogoutState extends AuthenticationState {}

class LoadingAuthenState extends AuthenticationState {}

class LoadingAuthenEndState extends AuthenticationState {}

class AppIntroState extends AuthenticationState {}
