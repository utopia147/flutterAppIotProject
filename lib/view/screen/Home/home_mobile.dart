import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/screen/Home/Components/body_home_mobile.dart';
import 'package:projectcontrol_app/view/screen/Menu/bottom_menu.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_mobile.dart';

class HomeMobile extends StatelessWidget {
  HomeMobile({Key key}) : super(key: key);
  int selectedMenu = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      key: _scaffoldKey,
      drawer: (orientation == Orientation.portrait)
          ? AppDrawer(
              selected: selectedMenu,
            )
          : null,
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: ScreenTypeLayout(
          mobile: OrientationLayout(
            landscape: BodyHomeMobileLandscape(selected: selectedMenu),
            portrait: BodyHomeMobliePortrait(),
          ),
          tablet: null,
          desktop: null,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      // bottomNavigationBar: BottomMenu(selectedMenu: selectedMenu),
    );
  }
}
