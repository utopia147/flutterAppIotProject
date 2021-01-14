import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_authen/authentication_bloc.dart';
import 'package:projectcontrol_app/view/screen/register/register_screen.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key key,
    @required AuthenticationBloc authBloc,
    @required GlobalKey<FormState> formkey,
    @required TextEditingController emailcontroller,
    @required TextEditingController passwordcontroller,
  })  : _authBloc = authBloc,
        _formkey = formkey,
        _emailcontroller = emailcontroller,
        _passwordcontroller = passwordcontroller,
        super(key: key);

  final AuthenticationBloc _authBloc;
  final GlobalKey<FormState> _formkey;
  final TextEditingController _emailcontroller;
  final TextEditingController _passwordcontroller;

  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;
    bool bCheckEmail = false;
    bool bCheckPassword = false;
    String errorPass;
    String errorEmail;
    String validatorEmail(String value) {
      Pattern regexEmailPattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(regexEmailPattern);
      if (!regex.hasMatch(value)) {
        bCheckEmail = false;
        errorEmail = "กรุณากรอกอีเมล ตัวอย่าง your@email.com";
      } else if (regex.hasMatch(value)) {
        bCheckEmail = true;
        errorEmail = null;
      }
      _authBloc.add(CheckFormEvent(bCheckEmail, bCheckPassword));
      return errorEmail;
    }

    String validatePassword(String value) {
      Pattern regexPasswordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
      RegExp regex = new RegExp(regexPasswordPattern);

      if (value.length < 6 || !regex.hasMatch(value)) {
        bCheckPassword = false;
        errorPass =
            "รหัสควรมีความยาวอย่างน้อย 6 ตัวอักษรหรือมากกว่านั้น\nประกอบด้วย ตัวอักษร (a-z, A-Z) ตัวเลข (0-9) อย่างน้อย 1 ตัว";
      } else {
        bCheckPassword = true;
        errorPass = null;
      }

      return errorPass;
    }

    Widget _iconCheckEmail(AuthenticationState state) {
      if (state is CheckFormState) {
        if (_formkey.currentState == null) {
          return Container();
        } else if (state.checkEmailState && _emailcontroller.text.isNotEmpty) {
          return Icon(Icons.check, color: Colors.greenAccent);
        } else if (!state.checkEmailState) {
          return Icon(Icons.clear, color: Colors.red);
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    }

    Widget _iconCheckPassword(AuthenticationState state) {
      if (state is CheckFormState) {
        if (_formkey.currentState == null) {
          return Container();
        } else if (state.checkPasswordState &&
            _passwordcontroller.text.isNotEmpty) {
          return Icon(Icons.check, color: Colors.greenAccent);
        } else if (!state.checkPasswordState) {
          return Icon(Icons.clear, color: Colors.red);
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      cubit: _authBloc,
      builder: (BuildContext context, AuthenticationState state) {
        return Form(
          autovalidate: true,
          key: _formkey,
          child: Column(
            children: [
              Image.asset('images/logo.png'),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      cursorColor: Colors.green,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      controller: _emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: validatorEmail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.all(0.1),
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .85,
                            top: 16),
                        child: _iconCheckEmail(state),
                      ),
                    ],
                  )
                ],
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      cursorColor: Colors.red,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      obscureText: true,
                      controller: _passwordcontroller,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        contentPadding: EdgeInsets.all(0.1),
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .85,
                            top: 26),
                        child: _iconCheckPassword(state),
                      ),
                    ],
                  )
                ],
              ),
              CheckboxListTile(
                  title: Text(
                    'Remember me',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _isChecked,
                  contentPadding: EdgeInsets.only(left: 40),
                  activeColor: Colors.pink,
                  onChanged: (bool value) async {
                    _isChecked = value;
                    print(_isChecked);
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.blue,
                        child: Text('Login',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          _authBloc.add(LoginEvent(_emailcontroller.text,
                              _passwordcontroller.text, _isChecked));
                        }),
                    RaisedButton(
                        color: Colors.orange,
                        child: Text('Register',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          _authBloc.close();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
