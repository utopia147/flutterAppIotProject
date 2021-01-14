import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DHTGaugeWidget extends StatelessWidget {
  const DHTGaugeWidget({
    Key key,
    @required this.temp,
    @required this.humidity,
  }) : super(key: key);

  final double temp;
  final double humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
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
                        horizontalAlignment: GaugeAlignment.center,
                        widget: Text(
                          (temp != null) ? '${temp} C*' : 'ไม่มีค่าอุณภูมิ',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        enableAnimation: true,
                        value: (temp != null) ? temp : 0,
                        width: 30,
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFFFFC107),
                          Color(0xFFB71C1C)
                        ], stops: <double>[
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
                    axisLabelStyle:
                        GaugeTextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
            ),
          ),
          Flexible(
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
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFF80DEEA),
                          Color(0xFF00ACC1)
                        ], stops: <double>[
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
          )
        ],
      ),
    );
  }
}
