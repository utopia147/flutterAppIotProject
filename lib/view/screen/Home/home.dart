import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/screen/Home/Components/body_home_mobile.dart';
import 'package:projectcontrol_app/view/screen/Menu/bottom_menu.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_mobile.dart';
import 'package:projectcontrol_app/view/screen/Home/home_mobile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobile(),
      tablet: null,
      desktop: null,
    );
  }
}
