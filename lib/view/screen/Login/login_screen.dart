import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_authen/authentication_bloc.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Login/Components/form_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _authBloc = AuthenticationBloc();
  var _emailcontroller = TextEditingController();
  var _passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      cubit: _authBloc,
      listener: (context, AuthenticationState state) {
        if (state is LoginSucessState) {
          _authBloc.close();
          return Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        } else if (state is LoginFailedState) {
          return showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('รหัสผ่านไม่ถูกต้องโปรดลองอีกครั้ง'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: Text('Try again'))
                  ],
                );
              });
        } else if (state is LoadingAuthenEndState) {
          Navigator.of(context).pop();
        } else if (state is LogoutState) {
          return Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false);
        } else if (state is LoadingAuthenState) {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text("Loading..."),
                  content: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                );
              });
        } else if (state is ErrorAuthenState) {
          return showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('${state.msg}'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: Text('Close'))
                  ],
                );
              });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormLogin(
                  authBloc: _authBloc,
                  formkey: _formkey,
                  emailcontroller: _emailcontroller,
                  passwordcontroller: _passwordcontroller,
                ),
                Container(
                  child: Center(
                    child: Text(
                      '\u00a9 2020 Project Control',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
