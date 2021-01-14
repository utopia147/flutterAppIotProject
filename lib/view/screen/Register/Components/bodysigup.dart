import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:projectcontrol_app/bloc/bloc_register/register_bloc.dart';
import 'package:projectcontrol_app/view/screen/Login/login_screen.dart';

class BodySigup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodySigup();
}

class _BodySigup extends State<BodySigup> {
  // ignore: non_constant_identifier_names
  RegisterBloc _registerBloc;
  File images;
  var _username = TextEditingController();
  var _password = TextEditingController();
  var _firstname = TextEditingController();
  var _lastname = TextEditingController();
  var _email = TextEditingController();
  String fileName;
  final _formkey = GlobalKey<FormState>();

  Widget _backButton() {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false);
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
              ),
              Text('Back',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _imagesBg(registerBloc) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<RegisterBloc, RegisterState>(
                cubit: _registerBloc,
                builder: (context, state) {
                  if (state is RegisterPickImageState) {
                    images = state.pickedImage;
                  } else if (state is RegisterImageLoadingState) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 4,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 3.5,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 10),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        scale: 0.2,
                        image: (images != null)
                            ? FileImage(images)
                            : AssetImage('images/regis1.png'),
                      ),
                    ),
                  );
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: FloatingActionButton(
                      tooltip: 'Upload Picture',
                      child: Icon(Icons.camera),
                      onPressed: () async {
                        File pickedFile = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        fileName = path.basename(pickedFile.path);
                        _registerBloc.add(RegisterImagePickEvent(pickedFile));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names

//Form Register
  BlocListener<RegisterBloc, RegisterState> formRegister(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is ErrorRegisterState) {
          return showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('${state.errorMsg}'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: Text('Close'))
                  ],
                );
              });
        } else if (state is RegisterSendSucessState) {
          return Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false);
        } else if (state is RegisterSendFailedState) {
          return showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text('ไม่สามารถสมัครได้โปรดลองอีกครั้ง'),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: Text('Try again'))
                  ],
                );
              });
        } else if (state is RegisterLoadingState) {
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
        } else if (state is RegisterLoadingDoneState) {
          Navigator.of(context).pop();
        }
      },
      child: Form(
        key: _formkey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'Sigup',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black38,
                    size: 20,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black26,
                  )),
                ),
                controller: _email,
                validator: validatorEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black38,
                    size: 20,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black26,
                  )),
                ),
                controller: _username,
                validator: vaildatorUsername,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.black38,
                    size: 20,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black26,
                  )),
                ),
                controller: _password,
                obscureText: true,
                validator: validatorPassword,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black26,
                        )),
                      ),
                      controller: _firstname,
                      validator: vaildatorFname,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Lastname',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black26,
                        )),
                      ),
                      controller: _lastname,
                      validator: vaildatorLname,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.orange[800],
                      child: Text('Create Account',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          print(images);
                          _registerBloc.add(RegisterSend(
                              _email.text,
                              _username.text,
                              _password.text,
                              _firstname.text,
                              _lastname.text,
                              images,
                              fileName));
                        } else {
                          return showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: Text('กรูณากรอกข้อมูลให้ครบ!'),
                                  actions: [
                                    FlatButton(
                                        onPressed: () =>
                                            Navigator.of(dialogContext).pop(),
                                        child: Text('Close'))
                                  ],
                                );
                              });
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//vaildate form
  String validatorEmail(String value) {
    String errorEmail;
    Pattern regexEmailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(regexEmailPattern);
    if (!regex.hasMatch(value)) {
      errorEmail = "*กรุณากรอกอีเมล example@example.com";
    } else if (regex.hasMatch(value)) {
      errorEmail = null;
    }
    return errorEmail;
  }

  String validatorPassword(String value) {
    Pattern regexPasswordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regex = new RegExp(regexPasswordPattern);
    String errorPass;
    if (value.length < 6 || !regex.hasMatch(value)) {
      errorPass =
          "*รหัสควรมีความยาวอย่างน้อย 6 ตัวอักษรหรือมากกว่านั้น\nประกอบด้วย ตัวอักษร (a-z, A-Z) ตัวเลข (0-9) อย่างน้อย 1 ตัว\n Example:Test123";
    } else {
      errorPass = null;
    }

    return errorPass;
  }

  String vaildatorUsername(String value) {
    String errorUsername;
    if (value.isEmpty) {
      errorUsername = '*กรุณากรอก Username';
    }
    return errorUsername;
  }

  String vaildatorFname(String value) {
    String errorFname;
    if (value.isEmpty) {
      errorFname = '*กรุณากรอกชื่อ';
    }
    return errorFname;
  }

  String vaildatorLname(String value) {
    String errorLname;
    if (value.isEmpty) {
      errorLname = '*กรุณากรอกนามสกุล';
    }
    return errorLname;
  }

  //Build Widget
  @override
  Widget build(BuildContext context) {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _backButton(),
          _imagesBg(_registerBloc),
          formRegister(context),
        ],
      ),
    );
  }
}
