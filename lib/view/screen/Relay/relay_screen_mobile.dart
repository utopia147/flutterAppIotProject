import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_relay/relay_bloc.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/screen/Menu/bottom_menu.dart';
import 'package:projectcontrol_app/view/screen/Relay/Components/body_relay_mobile.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer.dart';

class RelayScreenMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedMenu = 1;
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: (orientation == Orientation.portrait)
          ? AppDrawer(selected: selectedMenu)
          : null,
      body: BlocProvider(
        create: (context) => RelayBloc(),
        child: ScreenTypeLayout(
            mobile: OrientationLayout(
              landscape: BodyRelayLandScape(
                selectedAppDrawer: selectedMenu,
              ),
              portrait: BodyRelayPortrait(),
            ),
            tablet: null,
            desktop: null),
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
