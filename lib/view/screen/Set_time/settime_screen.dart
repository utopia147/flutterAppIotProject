import 'package:flutter/material.dart';
import 'package:projectcontrol_app/view/screen/Menu/bottom_menu.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_mobile.dart';

class SetTimeScreen extends StatefulWidget {
  int selectedMenu;
  SetTimeScreen(int selectedMenu) {
    this.selectedMenu = selectedMenu;
  }

  @override
  _SetTimeScreenState createState() => _SetTimeScreenState(selectedMenu);
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  int selectedMenu;
  _SetTimeScreenState(int selectedMenu) {
    this.selectedMenu = selectedMenu;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        title: Text('Set time'),
      ),
      // drawer: SideMenu(selectedMenu),
      body: null,
      bottomNavigationBar: BottomMenu(selectedMenu: selectedMenu),
    );
  }
}
