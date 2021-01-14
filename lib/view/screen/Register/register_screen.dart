import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_register/register_bloc.dart';
import 'package:projectcontrol_app/view/screen/Register/Components/bodysigup.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BodySigup(),
      ),
    );
  }
}
