import 'package:flutter/material.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Logdata/log_screen.dart';
import 'package:projectcontrol_app/view/screen/Relay/relay_screen.dart';
import 'package:projectcontrol_app/view/screen/Sensor/sensor_screen.dart';
import 'package:projectcontrol_app/view/screen/Set_time/settime_screen.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final int selectedMenu;

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  List<Widget> pageRoute = [
    HomeScreen(),
    RelayScreen(),
    SensorScreen(),
    SetTimeScreen(3),
    LogScreen(4)
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 16,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.pinkAccent,
      backgroundColor: Colors.black87,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedMenu,
      items: <BottomNavigationBarItem>[
        homeNav(),
        relayNav(),
        sensorNav(),
        settimeNav(),
        logNav()
      ],
      onTap: (int index) {
        print(widget.selectedMenu);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => pageRoute[index]),
            (Route<dynamic> route) => false);
      },
    );
  }
}

BottomNavigationBarItem homeNav() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.home),
    title: Text('Home'),
  );
}

BottomNavigationBarItem relayNav() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.lightbulb_outline),
    title: Text('Relay'),
  );
}

BottomNavigationBarItem sensorNav() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.multiline_chart),
    title: Text('Sensor'),
  );
}

BottomNavigationBarItem settimeNav() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.timer),
    title: Text('Set time'),
  );
}

BottomNavigationBarItem logNav() {
  return BottomNavigationBarItem(
    icon: Icon(Icons.storage),
    title: Text('Log'),
  );
}
