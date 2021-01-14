import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectcontrol_app/bloc/bloc_sensor/sensor_bloc.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/TabView/Components/dht_gauge_widget.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/TabView/Components/soilmoistrue_gauge_widget.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/TabView/Components/ultrasonic_gauge_widget.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/TabView/Components/voltage_gauge_widget.dart';

import 'package:projectcontrol_app/view/state_widget/alert_state.dart';
import 'package:projectcontrol_app/view/state_widget/empty_state.dart';
import 'package:projectcontrol_app/view/state_widget/error_state.dart';
import 'package:projectcontrol_app/view/widget/Form/form_sensor.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TabBodySensorGagueWidget extends StatelessWidget {
  const TabBodySensorGagueWidget({
    Key key,
    @required SensorBloc sensorBloc,
    @required this.category,
  })  : _sensorBloc = sensorBloc,
        super(key: key);

  final SensorBloc _sensorBloc;
  final String category;

  @override
  Widget build(BuildContext context) {
    var sensorWidget = <Widget>[];
    Widget _buildDeleteDht(sensorID) {
      return Align(
          alignment: Alignment.centerRight,
          child: CircleAvatar(
            backgroundColor: Colors.red[900],
            child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.trashAlt,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => _sensorBloc.add(DeleteSensor(sensorID))),
          ));
    }

    Widget _buildAboutSoilMoisture = Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text(
                    'รายละเอียดเซ็นเซอร์วัดความชื้นในดิน',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.data_usage,
                    color: Color(0xFF69F0AE),
                  ),
                  subtitle: Text(
                    'ค่าความชื้นอยู่ที่สีฟ้าหรือมีค่าน้อยกว่า 500 ความชื้นในดินเปียกเกินไป',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.data_usage,
                    color: Color(0xFFB2FF59),
                  ),
                  subtitle: Text(
                    'ค่าความชื้นอยู่ที่สีเขียวหรือมีค่าระหว่าง 600-700 ความชื้นในดินกำลังพอดี',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.data_usage,
                    color: Color(0xFFEEFF41),
                  ),
                  subtitle: Text(
                    'ค่าความชื้นอยู่ที่สีเหลืองหรือมีค่ามากกว่า 850 ความชื้นในดินแห้งเกินไป',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ));
    return BlocConsumer(
      cubit: _sensorBloc,
      listener: (context, state) {
        if (state is AddSensorState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormAddSensor(
                sensorBloc: _sensorBloc,
                nodemcuData: state.res,
                category: category,
              ),
            ),
          );
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
        }
      },
      builder: (context, state) {
        if (state is SensorInitial) {
          _sensorBloc.add(LoadDataSensor(category));
        } else if (state is LoadingStreamState) {
          sensorWidget = <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ];
        } else if (state is LoadedStreamState) {
          var sensorData = state.response;
          switch (category) {
            case 'DHT':
              sensorWidget = <Widget>[
                Column(
                  children: List.generate(state.response.length, (index) {
                    var sensorID = sensorData[index]['_id'];
                    double temp = sensorData[index]['sensorval'][0].toDouble();
                    double humidity =
                        sensorData[index]['sensorval'][1].toDouble();
                    return Column(
                      children: [
                        DHTGaugeWidget(temp: temp, humidity: humidity),
                        _buildDeleteDht(sensorID),
                      ],
                    );
                  }).toList(),
                )
              ];
              break;
            case 'Soil Moisture':
              sensorWidget = <Widget>[
                _buildAboutSoilMoisture,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(sensorData.length, (index) {
                      double soilMoistureVal =
                          sensorData[index]['sensorval'][0].toDouble();
                      int no = index + 1;
                      return PopupMenuButton(
                        onSelected: (value) {
                          _sensorBloc
                              .add(DeleteSensor(sensorData[value]['_id']));
                        },
                        itemBuilder: (context) {
                          return <PopupMenuItem>[
                            PopupMenuItem(
                              value: index,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  Text('Delete'),
                                ],
                              ),
                            )
                          ];
                        },
                        child: SoilMoistrueGaugeWidget(
                          no: no,
                          soilMoistureVal: soilMoistureVal,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ];
              break;
            case 'Voltage detection':
              sensorWidget = <Widget>[
                Column(
                  children: List.generate(sensorData.length, (index) {
                    var sensorID = sensorData[index]['_id'];
                    int no = index + 1;
                    double voltage =
                        sensorData[index]['sensorval'][0].toDouble();
                    double current =
                        sensorData[index]['sensorval'][1].toDouble();
                    double power = voltage * current;
                    double kWh = power / 1000;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'เซ็นเซอร์ตัวที่ $no',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () =>
                                        _sensorBloc.add(DeleteSensor(sensorID)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        VoltageGaugeWidget(
                            voltage: voltage,
                            current: current,
                            power: power,
                            kWh: kWh)
                      ],
                    );
                  }),
                ),
              ];
              break;
            case 'Ultrasonic Distance':
              sensorWidget = <Widget>[
                Column(
                  children: List.generate(sensorData.length, (index) {
                    var sensorID = sensorData[index]['_id'];
                    double cm = sensorData[index]['sensorval'][0].toDouble();
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'เซ้นเซอร์ตัวที่ ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () =>
                                        _sensorBloc.add(DeleteSensor(sensorID)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        UltrasonicGaugeWidget(cm: cm),
                      ],
                    );
                  }),
                )
              ];
              break;
            default:
          }
        } else if (state is LoadedDataSensorEmpty) {
          sensorWidget = <Widget>[
            EmptyDataWidget(
                heading: 'ไม่พบเซ็นเซอร์',
                content:
                    'กรุณาเพิ่มข้อมูล Sensor โดยการ\nกดไปที่ปุ่ม + มุมล่างขวา')
          ];
        } else if (state is ErrorSensorState) {
          sensorWidget = <Widget>[
            ErrorWidgetState(
              msg: '${state.errMsg}',
              onPressed: () => null,
            ),
          ];
        }
        return Column(
          children: sensorWidget,
        );
      },
    );
  }
}
