import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_sensor/sensor_bloc.dart';
import 'package:projectcontrol_app/view/screen/Menu/bottom_menu.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Details/detail_body.dart';
import 'package:projectcontrol_app/stream_api/stream_data.dart';

class DetailSensor extends StatelessWidget {
  final String bgimage;
  final int selectedMenu;
  final String categorys;
  final String sensors;
  DetailSensor(
      {Key key,
      @required this.sensors,
      @required this.bgimage,
      @required this.categorys,
      @required this.selectedMenu})
      : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      body: BlocProvider(
        create: (context) => SensorBloc(StreamData()),
        child: DetailBodySensor(
          sensors: sensors,
          bgimage: bgimage,
          categorys: categorys,
        ),
      ),
      bottomNavigationBar: BottomMenu(selectedMenu: selectedMenu),
    );
  }
}
