import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());
  SharedPreferences preferences;
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppIntro) {
      yield AppIntroState();
    } else if (event is LoginEvent) {
      yield* _mapLoginState(event);
    } else if (event is CheckAuthenEvent) {
      yield* _mapCheckAuthenState();
    } else if (event is LogoutEvent) {
      yield* _mapLogoutState();
    } else if (event is CheckFormEvent) {
      yield* _mapCheckFormState(event);
    }
  }

  //function Authentication State
  Stream<AuthenticationState> _mapLoginState(event) async* {
    try {
      yield LoadingAuthenState();
      await Future.delayed(Duration(seconds: 3));
      String path = "/api/auth/loginjwt";
      var authen = {'email': event.email, 'password': event.password};
      preferences = await SharedPreferences.getInstance();
      var data = await ApiProvider().loginApp(path, authen);
      if (event.rememberMe == true) {
        preferences.setBool("remember_me", event.rememberMe);
      }
      if (data != null) {
        preferences.setString('_id', data["User"]['_id']);
        preferences.setString('username', data["User"]['username']);
        preferences.setString('email', data["User"]['email']);
        preferences.setString('firstname', data["User"]['firstname']);
        preferences.setString('lastname', data["User"]['lastname']);
        print(data['User']);
        yield LoginSucessState();
      } else if (data == null) {
        yield LoadingAuthenEndState();
        yield LoginFailedState(data);
      }
    } catch (e) {
      yield LoadingAuthenEndState();
      if (e is DioError) {
        yield ErrorAuthenState('$e.message');
      }
      yield ErrorAuthenState(e.toString());
    }
  }

  Stream<AuthenticationState> _mapCheckAuthenState() async* {
    try {
      preferences = await SharedPreferences.getInstance();
      bool rememberMe = preferences.getBool("remember_me");
      String token = preferences.getString("token");
      if (rememberMe == true && token != null) {
        yield LoginSucessState();
      } else {
        yield LogoutState();
      }
    } catch (e) {
      yield ErrorAuthenState(e.toString());
    }
  }

  Stream<AuthenticationState> _mapLogoutState() async* {
    try {
      preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      yield LoadingAuthenState();
      await Future.delayed(Duration(seconds: 2));
      yield LogoutState();
    } catch (e) {
      yield ErrorAuthenState(e.toString());
    }
  }
}

Stream<AuthenticationState> _mapCheckFormState(event) async* {
  try {
    yield CheckFormState(event.checkEmail, event.checkPassword);
  } catch (e) {
    yield ErrorAuthenState(e.toString());
  }
}
