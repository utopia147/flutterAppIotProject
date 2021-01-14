import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WidgetSoilMoisture extends StatelessWidget {
  const WidgetSoilMoisture({
    Key key,
    @required this.snapshotList,
  }) : super(key: key);

  final List snapshotList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(top: 40),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.help_outline),
                          title: Text(
                            'รายละเอียดเซ็นเซอร์วัดความชื้นในดิน',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black87),
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
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                double soilMoistureVal =
                    snapshotList[index]['sensorval'][0].toDouble();
                int no = index + 1;
                return Row(
                  children: [
                    Flexible(
                      child: Card(
                          color: Colors.white,
                          child: Container(
                            child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 2000,
                              title: GaugeTitle(
                                text: 'ค่าความชื้นในดินตัวที่ ${no.toString()}',
                                textStyle: TextStyle(color: Colors.black),
                              ),
                              axes: <RadialAxis>[
                                RadialAxis(
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      axisValue: 50,
                                      positionFactor: 0.15,
                                      widget: Text(
                                        '${soilMoistureVal.toString()}',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    )
                                  ],
                                  pointers: <GaugePointer>[
                                    MarkerPointer(
                                        value: soilMoistureVal,
                                        markerOffset: -8.5,
                                        enableAnimation: true,
                                        animationDuration: 2000),
                                    RangePointer(
                                      enableAnimation: true,
                                      value: soilMoistureVal,
                                      width: 5,
                                      gradient: const SweepGradient(
                                          colors: <Color>[
                                            Color(0xFF424242),
                                            Color(0xFF212121)
                                          ],
                                          stops: <double>[
                                            0.25,
                                            0.75
                                          ]),
                                    )
                                  ],
                                  minimum: 0,
                                  maximum: 1023,
                                  startAngle: 90,
                                  endAngle: 90,
                                  interval: 10,
                                  canScaleToFit: true,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 20,
                                    gradient: const SweepGradient(
                                      colors: <Color>[
                                        Color(0xFF69F0AE),
                                        Color(0xFFB2FF59),
                                        Color(0xFFEEFF41),
                                      ],
                                      stops: <double>[0.3, 0.79, 0.1],
                                    ),
                                  ),
                                  showTicks: false,
                                  showLabels: false,
                                  axisLabelStyle: GaugeTextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              },
              childCount: snapshotList.length,
            ),
          ),
        ],
      ),
    );
  }
}
