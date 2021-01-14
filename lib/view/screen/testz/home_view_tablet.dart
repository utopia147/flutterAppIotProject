import 'package:flutter/material.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer.dart';

class HomeTabletPortrait extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeTabletPortrait({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
          )
        ],
      ),
    );
  }
}

class HomeTabletLandScape extends StatelessWidget {
  const HomeTabletLandScape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(),
        ],
      ),
    );
  }
}
