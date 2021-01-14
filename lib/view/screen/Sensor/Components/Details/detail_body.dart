import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_sensor/sensor_bloc.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Details/Components/widget_dht.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Details/Components/widget_soilmoisture.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Details/Components/widget_voltage.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Details/detail_sensor.dart';
import 'package:projectcontrol_app/view/screen/Sensor/sensor_screen.dart';
import 'package:projectcontrol_app/view/state_widget/add_widget.dart';
import 'package:projectcontrol_app/view/state_widget/alert_state.dart';
import 'package:projectcontrol_app/view/state_widget/empty_state.dart';
import 'package:projectcontrol_app/view/state_widget/error_state.dart';

class DetailBodySensor extends StatelessWidget {
  final String bgimage;
  final String categorys;
  final String sensors;
  DetailBodySensor(
      {Key key,
      @required this.sensors,
      @required this.bgimage,
      @required this.categorys})
      : super(key: key);

  ApiProvider apiProvider = ApiProvider();
  SensorBloc _sensorBloc;
  var children = <Widget>[];
  var showDialogDel;
  @override
  Widget build(BuildContext context) {
    _sensorBloc = BlocProvider.of<SensorBloc>(context);
    Widget _backButton() {
      return SafeArea(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => SensorScreen()),
                (Route<dynamic> route) => false);
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Container(
                  child: Text('Back',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget _categoryBg() {
      return Hero(
        tag: 'hero-tag-${bgimage}',
        child: DecoratedBox(
          child: Center(
            child: Text(
              '${categorys}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.3),
                  decoration: TextDecoration.none),
            ),
          ),
          decoration: BoxDecoration(
            color:
                (bgimage == 'images/dhtbg.png') ? Colors.black : Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  '${bgimage}',
                ),
                fit: BoxFit.fill,
                scale: 1,
                alignment: Alignment.bottomCenter,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.srcOver)),
          ),
        ),
      );
    }

    return Stack(
      children: [
        _categoryBg(),
        BlocConsumer<SensorBloc, SensorState>(
          cubit: _sensorBloc,
          listener: (context, state) {
            if (state is AddSensorState) {
              int no = 0;

              String selected = state.res[0]['_id'];
              String nodemcuid = selected;
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogContext) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          top: -10,
                          right: -10,
                          child: InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.pinkAccent,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              _sensorBloc.add(LoadDataSensor(sensors));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Form(
                            // key: _formKey,
                            autovalidate: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.bubble_chart,
                                          color: Colors.pinkAccent,
                                        ),
                                        labelText: 'เลือก Project'),
                                    value: selected,
                                    icon: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.pinkAccent,
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (String newValue) {
                                      print(newValue);
                                      nodemcuid = newValue;
                                    },
                                    items: state.res
                                        .map<DropdownMenuItem<String>>((data) {
                                      no++;
                                      return DropdownMenuItem<String>(
                                        value: data['_id'],
                                        child: Text(
                                          '${data['nodemcuProject']}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    color: Colors.pinkAccent,
                                    child: Text(
                                      "เพิ่ม",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _sensorBloc.add(SendAddSensorData(
                                          nodemcuid, sensors));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is SendAddSensorDoneState ||
                state is DeleteSuscessfulState) {
              return Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => DetailSensor(
                            sensors: sensors,
                            bgimage: bgimage,
                            categorys: categorys,
                            selectedMenu: 2,
                          )),
                  (Route<dynamic> route) => false);
            } else if (state is DeleteConfirmState) {
              print(state.sensorID);
              String sensorID = state.sensorID;
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => AlertDialogStateWidget(
                      alertHeadline: 'ยืนยัน',
                      alertMsg: 'คุณต้องการลบเซ็นเซอร์ตัวนี้หรือไม่',
                      goToMenu: 'ลบ',
                      cancelMenu: 'ยกเลิก',
                      goToOnPressed: () {
                        _sensorBloc.add(ConfirmDelete(sensorID));
                        Navigator.of(context).pop();
                      },
                      cancelOnPressed: () {
                        _sensorBloc.add(ResumeStream());
                        Navigator.of(context).pop();
                      }));
            } else if (state is AlertSensorState) {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => AlertDialogStateWidget(
                        alertHeadline: 'ไม่สามารถาเพิ่มเซ็นเซอร์ได้',
                        alertMsg: state.alertMsg,
                        goToMenu: 'ไปที่ NodeMCU',
                        goToOnPressed: () => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()),
                                (Route<dynamic> route) => false),
                        cancelMenu: 'ยกเลิก',
                        cancelOnPressed: () {
                          _sensorBloc.add(ResumeStream());
                          Navigator.of(context).pop();
                        },
                      ));
            }
          },
          builder: (context, state) {
            if (state is SensorInitial) {
              _sensorBloc.add(LoadDataSensor(sensors));
            } else if (state is LoadingStreamState) {
              children = <Widget>[Center(child: CircularProgressIndicator())];
            } else if (state is LoadedStreamState) {
              List snapshotList = state.response;
              // print(snapshotList);
              switch (sensors) {
                case 'DHT':
                  children = <Widget>[
                    WidgetDHT(
                        snapshotList: snapshotList, sensorBloc: _sensorBloc),
                  ];
                  break;
                case 'Soil Moisture':
                  children = <Widget>[
                    WidgetSoilMoisture(snapshotList: snapshotList),
                  ];
                  break;
                case 'Voltage detection':
                  children = <Widget>[
                    WidgetVoltageDetection(snapshotList: snapshotList),
                  ];
                  break;
                case 'Ultrasonic Distance':
                  children = <Widget>[];
                  break;
                default:
              }
            } else if (state is LoadedDataSensorEmpty) {
              children = <Widget>[
                EmptyDataWidget(
                    heading: 'ไม่พบเซ็นเซอร์',
                    content:
                        'กรุณาเพิ่มข้อมูล Sensor โดยการ\nกดไปที่ปุ่ม + มุมล่างขวา')
              ];
            } else if (state is ErrorSensorState) {
              children = <Widget>[
                ErrorWidgetState(
                  msg: '${state.errMsg}',
                  onPressed: () => _sensorBloc.add(StreamSensor(sensors)),
                )
              ];
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
          },
        ),
        _backButton(),
        AddWidget(
            tooltip: 'เพิ่มเซ็นเซอร์',
            onPressed: () {
              print('tap');

              _sensorBloc.add(AddSensorData());
            }),
      ],
    );
  }
}
