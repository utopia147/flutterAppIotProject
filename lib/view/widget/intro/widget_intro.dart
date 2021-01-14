import 'package:flutter/material.dart';
import 'package:projectcontrol_app/bloc/bloc_authen/authentication_bloc.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/widget/intro/widget_intro_mobile.dart';

class WidgetIntro extends StatelessWidget {
  const WidgetIntro({
    Key key,
    @required this.authenticationBloc,
  }) : super(key: key);
  final AuthenticationBloc authenticationBloc;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: WidgetIntroMobile(authenticationBloc: authenticationBloc),
      tablet: null,
      desktop: null,
    );
  }
}
