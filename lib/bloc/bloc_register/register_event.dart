part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterSend extends RegisterEvent {
  final String email;
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  var avatar;
  final String fileName;
  RegisterSend(this.email, this.username, this.password, this.firstname,
      this.lastname, this.avatar, this.fileName);
}

class RegisterImagePickEvent extends RegisterEvent {
  final File images;
  RegisterImagePickEvent(this.images);
}
