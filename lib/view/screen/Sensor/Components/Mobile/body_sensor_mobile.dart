import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectcontrol_app/bloc/bloc_log/log_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_sensor/sensor_bloc.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/TabView/tab_body_sensor_barchart.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/TabView/tab_body_sensor_gague.dart';

import 'package:projectcontrol_app/view/state_widget/add_widget.dart';

class BodySensorPortrait extends StatefulWidget {
  BodySensorPortrait({
    Key key,
    @required this.itemCategory,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required TabController tabController,
  })  : _scaffoldKey = scaffoldKey,
        _tabController = tabController,
        super(key: key);

  final List<Map<String, Object>> itemCategory;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final TabController _tabController;

  @override
  _BodySensorPortraitState createState() => _BodySensorPortraitState();
}

class _BodySensorPortraitState extends State<BodySensorPortrait> {
  SensorBloc _sensorBloc;
  LogBloc _logBloc;
  String category = 'DHT';
  List<int> tabs = [1, 2, 3, 4];
  var tabBody;
  var tabPage;
  @override
  Widget build(BuildContext context) {
    _sensorBloc = BlocProvider.of<SensorBloc>(context);
    _logBloc = BlocProvider.of<LogBloc>(context);
    return Stack(
      children: [
        DefaultTabController(
          length: tabs.length,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    expandedHeight: 200,
                    title: Text('Sensor'),
                    floating: false,
                    pinned: true,
                    snap: false,
                    actions: [buildCategory()],
                    leading: IconButton(
                      icon: Icon(
                        Icons.menu,
                      ),
                      onPressed: () =>
                          widget._scaffoldKey.currentState.openDrawer(),
                    ),
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          child: Icon(Icons.av_timer),
                        ),
                        Tab(child: Icon(Icons.insert_chart)),
                        Tab(child: Icon(Icons.pie_chart)),
                        Tab(child: Icon(Icons.show_chart)),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: tabs.map(
                (int tab) {
                  return SafeArea(
                    child: Builder(builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey(tab),
                        slivers: [
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(0),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  switch (tab) {
                                    case 1:
                                      tabBody = TabBodySensorGagueWidget(
                                          sensorBloc: _sensorBloc,
                                          category: category);

                                      break;
                                    case 2:
                                      tabBody = TabBodySensorBarchart(
                                          category: category,
                                          logBloc: _logBloc);
                                      break;
                                    case 3:
                                      tabBody = Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        color: Colors.blueAccent,
                                      );
                                      break;
                                    case 4:
                                      tabBody = Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        color: Colors.greenAccent,
                                      );
                                      break;
                                    default:
                                  }
                                  return tabBody;
                                },
                                childCount: 1,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        AddWidget(
            tooltip: 'เพิ่มเซ็นเซอร์',
            onPressed: () => _sensorBloc.add(AddSensorData()))
      ],
    );
  }

  Widget buildCategory() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: PopupMenuButton(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text('$category'),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        itemBuilder: (BuildContext context) => widget.itemCategory
            .map((item) => PopupMenuItem(
                  child: ListTile(
                    leading: FaIcon(
                      item['icon'],
                      color: Colors.pinkAccent,
                    ),
                    title: Text(item['name']),
                  ),
                  value: item['name'],
                ))
            .toList(),
        onSelected: (value) {
          setState(() {
            category = value;
          });
          _sensorBloc.add(LoadDataSensor(category));
          _logBloc.add(LogFetchedData(category));
        },
      ),
    );
  }
}
