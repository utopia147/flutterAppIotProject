part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadingDoneState extends RegisterState {}

class RegisterSendSucessState extends RegisterState {}

class RegisterSendFailedState extends RegisterState {}

class RegisterPickImageState extends RegisterState {
  final File pickedImage;
  RegisterPickImageState(this.pickedImage);
}

class RegisterImageLoadingState extends RegisterState {}

class ErrorRegisterState extends RegisterState {
  final String errorMsg;
  ErrorRegisterState(this.errorMsg);
}
