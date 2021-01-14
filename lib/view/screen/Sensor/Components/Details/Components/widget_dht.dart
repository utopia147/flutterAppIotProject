import 'package:flutter/material.dart';
import 'package:projectcontrol_app/bloc/bloc_sensor/sensor_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WidgetDHT extends StatelessWidget {
  const WidgetDHT({
    Key key,
    @required this.snapshotList,
    @required this.sensorBloc,
  }) : super(key: key);

  final List snapshotList;
  final SensorBloc sensorBloc;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.height /
                    1.3 /
                    MediaQuery.of(context).size.width),
            itemCount: snapshotList.length,
            itemBuilder: (BuildContext context, int index) {
              double temp = snapshotList[index]['sensorval'][0].toDouble();
              double humidity = snapshotList[index]['sensorval'][1].toDouble();

              return Stack(
                overflow: Overflow.visible,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Card(
                            color: Colors.black87.withOpacity(0.3),
                            child: Container(
                                child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 2000,
                              title: GaugeTitle(
                                  text: 'Temperature',
                                  textStyle: TextStyle(color: Colors.white)),
                              axes: <RadialAxis>[
                                RadialAxis(
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      positionFactor: 0.2,
                                      horizontalAlignment:
                                          GaugeAlignment.center,
                                      widget: Text(
                                        (snapshotList[index]['sensorval']
                                                    .length !=
                                                0)
                                            ? '${temp} C*'
                                            : 'ไม่มีค่าอุณภูมิ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    )
                                  ],
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      enableAnimation: true,
                                      value: (temp != null) ? temp : 0,
                                      width: 30,
                                      gradient: const SweepGradient(
                                          colors: <Color>[
                                            Color(0xFFFFC107),
                                            Color(0xFFB71C1C)
                                          ],
                                          stops: <double>[
                                            0.25,
                                            0.75
                                          ]),
                                    )
                                  ],
                                  minimum: 0,
                                  maximum: 50,
                                  startAngle: 180,
                                  endAngle: 0,
                                  interval: 10,
                                  canScaleToFit: true,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 30,
                                  ),
                                  showTicks: false,
                                  showLabels: false,
                                  axisLabelStyle: GaugeTextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ],
                            )),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: Card(
                            color: Colors.white.withOpacity(0.7),
                            child: Container(
                                child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 2000,
                              title: GaugeTitle(
                                text: 'Humidity',
                              ),
                              axes: <RadialAxis>[
                                RadialAxis(
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      axisValue: 50,
                                      positionFactor: 0.25,
                                      widget: Text(
                                        (humidity != null)
                                            ? '${humidity} %'
                                            : 'ไม่มีค่าความชื้น',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      enableAnimation: true,
                                      value: (humidity != null) ? humidity : 0,
                                      width: 20,
                                      gradient: const SweepGradient(
                                          colors: <Color>[
                                            Color(0xFF80DEEA),
                                            Color(0xFF00ACC1)
                                          ],
                                          stops: <double>[
                                            0.25,
                                            0.75
                                          ]),
                                    )
                                  ],
                                  minimum: 20,
                                  maximum: 60,
                                  startAngle: 90,
                                  endAngle: 90,
                                  interval: 10,
                                  canScaleToFit: true,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 20,
                                  ),
                                  showTicks: false,
                                  showLabels: false,
                                  axisLabelStyle: GaugeTextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -11,
                    right: 6,
                    child: Row(
                      children: [
                        // Container(
                        //   width: 30,
                        //   height: 30,
                        //   child: InkWell(
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.orangeAccent,
                        //       child: Icon(
                        //         Icons.edit,
                        //         color: Colors.white,
                        //         size: 12,
                        //       ),
                        //     ),
                        //     onTap: () {
                        //       // sensorBloc.add(DeleteSensor());
                        //       print('edit');
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          child: InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.red[800],
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            onTap: () {
                              sensorBloc.add(
                                  DeleteSensor(snapshotList[index]['_id']));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
