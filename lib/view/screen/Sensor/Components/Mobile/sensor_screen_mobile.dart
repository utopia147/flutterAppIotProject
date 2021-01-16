import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectcontrol_app/bloc/bloc_log/log_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_sensor/sensor_bloc.dart';
import 'package:projectcontrol_app/resources/api_repository.dart';
import 'package:projectcontrol_app/stream_api/stream_data.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/body_sensor_mobile.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer.dart';

class SensorScreenMobile extends StatefulWidget {
  @override
  _SensorScreenMobileState createState() => _SensorScreenMobileState();
}

class _SensorScreenMobileState extends State<SensorScreenMobile>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String category = 'Category';

  var itemCategory = [
    {'name': 'DHT', 'icon': FontAwesomeIcons.temperatureLow},
    {'name': 'Soil Moisture', 'icon': FontAwesomeIcons.pagelines},
    {'name': 'Voltage detection', 'icon': FontAwesomeIcons.bolt},
    {'name': 'Ultrasonic Distance', 'icon': FontAwesomeIcons.waveSquare}
  ];
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  int selectedMenu = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(selected: selectedMenu),

      body: MultiBlocProvider(
        providers: [
          BlocProvider<SensorBloc>(
            create: (context) => SensorBloc(StreamData()),
          ),
          BlocProvider<LogBloc>(create: (context) => LogBloc(ApiRepository())),
        ],
        child: BodySensorPortrait(
            itemCategory: itemCategory,
            scaffoldKey: _scaffoldKey,
            tabController: _tabController),
      ),
      // bottomNavigationBar: BottomMenu(selectedMenu: selectedMenu),
    );
  }
}
