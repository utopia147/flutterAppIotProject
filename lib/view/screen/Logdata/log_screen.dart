import 'package:flutter/material.dart';
import 'package:projectcontrol_app/view/screen/Menu/bottom_menu.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_mobile.dart';

class LogScreen extends StatefulWidget {
  int selectedMenu;
  LogScreen(int selectedMenu) {
    this.selectedMenu = selectedMenu;
  }

  @override
  _LogScreenState createState() => _LogScreenState(selectedMenu);
}

class _LogScreenState extends State<LogScreen> {
  int selectedMenu;
  _LogScreenState(int selectedMenu) {
    this.selectedMenu = selectedMenu;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFB8C00),
            const Color(0xFFFF3D00),
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text('Log'),
        ),
        // drawer: SideMenu(selectedMenu),
        body: null,
        bottomNavigationBar: BottomMenu(selectedMenu: selectedMenu),
      ),
    );
  }
}
