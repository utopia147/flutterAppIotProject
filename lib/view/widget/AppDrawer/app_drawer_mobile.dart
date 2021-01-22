import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Logdata/log_screen.dart';
import 'package:projectcontrol_app/view/screen/Login/login_screen.dart';
import 'package:projectcontrol_app/view/screen/Menu/menu_model.dart';
import 'package:projectcontrol_app/view/screen/Relay/relay_screen.dart';
import 'package:projectcontrol_app/view/screen/Sensor/sensor_screen.dart';
import 'package:projectcontrol_app/view/screen/Set_time/settime_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawerMobilePortrait extends StatefulWidget {
  int selected;

  AppDrawerMobilePortrait(int selected) {
    this.selected = selected;
  }
  @override
  _AppDrawerMobilePortrait createState() => _AppDrawerMobilePortrait(selected);
}

class _AppDrawerMobilePortrait extends State<AppDrawerMobilePortrait> {
  ApiProvider apiProvider = ApiProvider();
  int selectedMenu;
  String name;
  String email;
  _AppDrawerMobilePortrait(int selected) {
    this.selectedMenu = selected;
  }
  Future<dynamic> _getuser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userid = sharedPreferences.getString('_id');
    String path = 'api/users/' + userid;
    var res = apiProvider.getApiClient(path);
    return res;
  }

  List<MenuModel> menu = [
    MenuModel(
      menuName: 'Home',
      menuIcon: Icon(
        Icons.home,
        color: Colors.white,
      ),
      menuColor: Colors.greenAccent[700],
      pageRoute: HomeScreen(),
    ),
    MenuModel(
        menuName: 'Relay Control',
        menuIcon: Icon(
          Icons.lightbulb_outline,
          color: Colors.white,
        ),
        menuColor: Colors.pinkAccent[400],
        pageRoute: RelayScreen()),
    MenuModel(
      menuName: 'Sensor',
      menuIcon: Icon(
        Icons.multiline_chart,
        color: Colors.white,
      ),
      menuColor: Colors.blue[900],
      pageRoute: SensorScreen(),
    ),
    MenuModel(
      menuName: 'Set time',
      menuIcon: Icon(
        Icons.timer,
        color: Colors.white,
      ),
      menuColor: Colors.yellow,
      pageRoute: SetTimeScreen(3),
    ),
    MenuModel(
      menuName: 'Log',
      menuIcon: Icon(
        Icons.storage,
        color: Colors.white,
      ),
      menuColor: Colors.orange,
      pageRoute: LogScreen(4),
    ),
    MenuModel(
      menuName: 'Sign out',
      menuIcon: Icon(
        Icons.exit_to_app,
        color: Colors.red,
      ),
      menuColor: Colors.red,
    ),
  ];
  Widget menuList(index) {
    List<MenuModel> menu = [
      MenuModel(
        menuName: 'Home',
        menuIcon: Icon(
          Icons.home,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.greenAccent[700],
        pageRoute: HomeScreen(),
      ),
      MenuModel(
          menuName: 'Relay Control',
          menuIcon: Icon(
            Icons.lightbulb_outline,
            color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
          ),
          menuColor: Colors.pinkAccent[400],
          pageRoute: RelayScreen()),
      MenuModel(
        menuName: 'Sensor',
        menuIcon: Icon(
          Icons.multiline_chart,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.blue[900],
        pageRoute: SensorScreen(),
      ),
      MenuModel(
        menuName: 'Set time',
        menuIcon: Icon(
          Icons.timer,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.yellow,
        pageRoute: SetTimeScreen(3),
      ),
      MenuModel(
        menuName: 'Log',
        menuIcon: Icon(
          Icons.storage,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.orange,
        pageRoute: LogScreen(4),
      ),
      MenuModel(
        menuName: 'Sign out',
        menuIcon: Icon(
          Icons.exit_to_app,
          color: Colors.red,
        ),
        menuColor: Colors.red,
      ),
    ];
    var menus = menu[index];

    return Card(
      color: (index == selectedMenu) ? Colors.black12 : Colors.black,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: menus.menuColor, width: 5),
          ),
        ),
        child: ListTile(
            leading: menus.menuIcon,
            title: Text(
              menus.menuName,
              style: TextStyle(
                  color: (index == selectedMenu)
                      ? Colors.pinkAccent
                      : Colors.white),
            ),
            onTap: () {
              setState(() {
                selectedMenu = index;
                // print(selectedMenu);
                if (index == 5) {
                  showalertLogout();
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => menus.pageRoute),
                      (Route<dynamic> route) => false);
                }
              });
            }),
      ),
    );
  }

  void showalertLogout() {
    Widget continueButton = FlatButton(
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.clear();
          // sharedPreferences.commit();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false);
        },
        child: Text('Contiue'));
    Widget cancelButton = FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel'));
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          Text('Logout')
        ],
      ),
      content: Text('คุณต้องการออกจากระบบใช่หรือไม่'),
      actions: [continueButton, cancelButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Widget userAccountsDrawerHeader(snapshotData) {
    Map<String, dynamic> user;
    user = snapshotData;
    String imageNetwork = baseUri + user["avatar"];
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      accountName: Text(user["firstname"] + ' ' + user["lastname"]),
      accountEmail: Text(user['email']),
      currentAccountPicture: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(imageNetwork),
          backgroundColor: Colors.white,
          child: null),
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
            image: AssetImage(
              'images/logo.png',
            ),
            fit: BoxFit.fitWidth,
            scale: 1,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.srcOver)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      width: 300,
      color: Colors.grey[900],
      child: Row(
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 202,
                  child: FutureBuilder(
                    future: _getuser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return userAccountsDrawerHeader(snapshot.data);
                      }
                      return RefreshProgressIndicator();
                    },
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: menu.length,
                  itemBuilder: (context, index) => menuList(index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppDrawerMobileLandscape extends StatefulWidget {
  int selected;

  AppDrawerMobileLandscape(int selected) {
    this.selected = selected;
  }
  @override
  _AppDrawerMobileLandscape createState() =>
      _AppDrawerMobileLandscape(selected);
}

class _AppDrawerMobileLandscape extends State<AppDrawerMobileLandscape> {
  ApiProvider apiProvider = ApiProvider();
  int selectedMenu;
  String name;
  String email;
  _AppDrawerMobileLandscape(int selected) {
    this.selectedMenu = selected;
  }
  Future<dynamic> _getuser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userid = sharedPreferences.getString('_id');
    String path = 'api/users/' + userid;
    var res = apiProvider.getApiClient(path);
    return res;
  }

  List<MenuModel> menu = [
    MenuModel(
      menuName: 'Home',
      menuIcon: Icon(
        Icons.home,
        color: Colors.white,
      ),
      menuColor: Colors.greenAccent[700],
      pageRoute: HomeScreen(),
    ),
    MenuModel(
        menuName: 'Relay Control',
        menuIcon: Icon(
          Icons.lightbulb_outline,
          color: Colors.white,
        ),
        menuColor: Colors.pinkAccent[400],
        pageRoute: RelayScreen()),
    MenuModel(
      menuName: 'Sensor',
      menuIcon: Icon(
        Icons.multiline_chart,
        color: Colors.white,
      ),
      menuColor: Colors.blue[900],
      pageRoute: SensorScreen(),
    ),
    MenuModel(
      menuName: 'Set time',
      menuIcon: Icon(
        Icons.timer,
        color: Colors.white,
      ),
      menuColor: Colors.yellow,
      pageRoute: SetTimeScreen(3),
    ),
    MenuModel(
      menuName: 'Log',
      menuIcon: Icon(
        Icons.storage,
        color: Colors.white,
      ),
      menuColor: Colors.orange,
      pageRoute: LogScreen(4),
    ),
    MenuModel(
      menuName: 'Sign out',
      menuIcon: Icon(
        Icons.exit_to_app,
        color: Colors.red,
      ),
      menuColor: Colors.red,
    ),
  ];
  Widget menuList(index) {
    List<MenuModel> menu = [
      MenuModel(
        menuName: 'Home',
        menuIcon: Icon(
          Icons.home,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.greenAccent[700],
        pageRoute: HomeScreen(),
      ),
      MenuModel(
          menuName: 'Relay Control',
          menuIcon: Icon(
            Icons.lightbulb_outline,
            color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
          ),
          menuColor: Colors.pinkAccent[400],
          pageRoute: RelayScreen()),
      MenuModel(
        menuName: 'Sensor',
        menuIcon: Icon(
          Icons.multiline_chart,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.blue[900],
        pageRoute: SensorScreen(),
      ),
      MenuModel(
        menuName: 'Set time',
        menuIcon: Icon(
          Icons.timer,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.yellow,
        pageRoute: SetTimeScreen(3),
      ),
      MenuModel(
        menuName: 'Log',
        menuIcon: Icon(
          Icons.storage,
          color: (index == selectedMenu) ? Colors.pinkAccent : Colors.white,
        ),
        menuColor: Colors.orange,
        pageRoute: LogScreen(4),
      ),
      MenuModel(
        menuName: 'Sign out',
        menuIcon: Icon(
          Icons.exit_to_app,
          color: Colors.red,
        ),
        menuColor: Colors.red,
      ),
    ];
    var menus = menu[index];

    return Card(
      color: (index == selectedMenu) ? Colors.black12 : Colors.black,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: menus.menuColor, width: 5),
          ),
        ),
        child: ListTile(
            title: menus.menuIcon,
            onTap: () {
              setState(() {
                selectedMenu = index;
                // print(selectedMenu);
                if (index == 5) {
                  showalertLogout();
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => menus.pageRoute),
                      (Route<dynamic> route) => false);
                }
              });
            }),
      ),
    );
  }

  void showalertLogout() {
    Widget continueButton = FlatButton(
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.clear();
          // sharedPreferences.commit();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false);
        },
        child: Text('Contiue'));
    Widget cancelButton = FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel'));
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          Text('Logout')
        ],
      ),
      content: Text('คุณต้องการออกจากระบบใช่หรือไม่'),
      actions: [continueButton, cancelButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Widget userAccountsDrawerHeader(snapshotData) {
    Map<String, dynamic> user;
    user = snapshotData;
    String imageNetwork = baseUri + user["avatar"];
    return Container(
      height: 100,
      margin: EdgeInsets.all(30),
      child: InkWell(
        onTap: () => print('tap'),
        child: CircleAvatar(
            radius: 10.0,
            backgroundImage: NetworkImage(imageNetwork, scale: 1),
            backgroundColor: Colors.white,
            child: null),
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        image: DecorationImage(
            image: AssetImage(
              'images/logo.png',
            ),
            fit: BoxFit.fitWidth,
            scale: 1,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.srcOver)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                FutureBuilder(
                  future: _getuser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return userAccountsDrawerHeader(snapshot.data);
                    }
                    return RefreshProgressIndicator();
                  },
                ),
                Column(
                  children:
                      List.generate(menu.length, (index) => menuList(index))
                          .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
