import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:http_parser/http_parser.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterSend) {
      yield* _mapRegisterSendToState(event);
    } else if (event is RegisterImagePickEvent) {
      yield* _mapRegisterImagePickToState(event);
    }
  }
}

Stream<RegisterState> _mapRegisterSendToState(event) async* {
  try {
    String path = 'api/auth/register';
    FormData formData = FormData.fromMap({
      'email': event.email,
      'username': event.username,
      'password': event.password,
      'firstname': event.firstname,
      'lastname': event.lastname,
      'avatar': (event.avatar != null)
          ? await MultipartFile.fromFile(event.avatar.path,
              filename: event.fileName, contentType: MediaType('image', 'jpeg'))
          : 'uploads/avatar/default-user-image.PNG',
    });
    print(event.avatar);
    yield RegisterLoadingState();

    var response = await ApiProvider().registerApiClient(path, formData);
    print(response);
    yield RegisterLoadingDoneState();
    if (response["response"][0]["suscess"] != null) {
      yield RegisterSendSucessState();
    } else {
      yield RegisterSendFailedState();
    }
  } catch (e) {
    if (e is DioError) {
      ErrorRegisterState(e.message.toString());
    }
    ErrorRegisterState(e.toString());
  }
}

Stream<RegisterState> _mapRegisterImagePickToState(event) async* {
  try {
    yield RegisterImageLoadingState();
    await Future.delayed(Duration(milliseconds: 5000));
    yield RegisterPickImageState(event.images);
  } catch (e) {
    ErrorRegisterState(e.toString());
  }
}
