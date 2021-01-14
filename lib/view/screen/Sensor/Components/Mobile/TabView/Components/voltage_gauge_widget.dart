import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class VoltageGaugeWidget extends StatelessWidget {
  const VoltageGaugeWidget({
    Key key,
    @required this.voltage,
    @required this.current,
    @required this.power,
    @required this.kWh,
  }) : super(key: key);

  final double voltage;
  final double current;
  final double power;
  final double kWh;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Voltage gague widget
          Container(
            height: 200,
            width: 200,
            child: Card(
              color: Colors.blueAccent[700],
              child: Container(
                  child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 2000,
                title: GaugeTitle(
                    text: 'VOLTAGE',
                    textStyle: TextStyle(color: Colors.white70)),
                axes: <RadialAxis>[
                  RadialAxis(
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        horizontalAlignment: GaugeAlignment.center,
                        widget: Text(
                          '${voltage} V',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: voltage,
                        markerOffset: -8,
                        enableAnimation: true,
                        animationDuration: 2000,
                      ),
                      RangePointer(
                        enableAnimation: true,
                        value: voltage,
                        width: 13,
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFF07EEFF),
                          Color(0xFF1C6CB7)
                        ], stops: <double>[
                          0.25,
                          0.80
                        ]),
                      )
                    ],
                    minimum: 0,
                    maximum: 250,
                    startAngle: 170,
                    endAngle: 10,
                    interval: 250,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 13,
                    ),
                    showTicks: false,
                    showFirstLabel: true,
                    showLastLabel: true,
                    showLabels: true,
                    axisLabelStyle:
                        GaugeTextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
            ),
          ),
          // Current gauge widget
          Container(
            height: 200,
            width: 200,
            child: Card(
              color: Colors.red[900],
              child: Container(
                  child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 2000,
                title: GaugeTitle(
                    text: 'CURRENT',
                    textStyle: TextStyle(color: Colors.white70)),
                axes: <RadialAxis>[
                  RadialAxis(
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        horizontalAlignment: GaugeAlignment.center,
                        widget: Text(
                          '${current} A',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: current,
                        markerOffset: -8,
                        enableAnimation: true,
                        animationDuration: 2000,
                        color: Colors.red,
                      ),
                      RangePointer(
                        enableAnimation: true,
                        value: current,
                        width: 13,
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFFFF4107),
                          Color(0xFFB7211C)
                        ], stops: <double>[
                          0.25,
                          0.80
                        ]),
                      )
                    ],
                    minimum: 0,
                    maximum: 15,
                    startAngle: 170,
                    endAngle: 10,
                    interval: 15,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 13,
                    ),
                    showTicks: false,
                    showFirstLabel: true,
                    showLastLabel: true,
                    showLabels: true,
                    axisLabelStyle:
                        GaugeTextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
            ),
          ),
          //Power gauge widget
          Container(
            height: 200,
            width: 200,
            child: Card(
              color: Colors.purple[900],
              child: Container(
                  child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 2000,
                title: GaugeTitle(
                    text: 'POWER', textStyle: TextStyle(color: Colors.white70)),
                axes: <RadialAxis>[
                  RadialAxis(
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        horizontalAlignment: GaugeAlignment.center,
                        widget: Text(
                          '${power} W',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: power,
                        markerOffset: -8,
                        enableAnimation: true,
                        animationDuration: 2000,
                        color: Colors.purple,
                      ),
                      RangePointer(
                        enableAnimation: true,
                        value: power,
                        width: 13,
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFFEA07FF),
                          Color(0xFF9D1CB7)
                        ], stops: <double>[
                          0.25,
                          0.80
                        ]),
                      )
                    ],
                    minimum: 0,
                    maximum: 3000,
                    startAngle: 170,
                    endAngle: 10,
                    interval: 3000,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 13,
                    ),
                    showTicks: false,
                    showFirstLabel: true,
                    showLastLabel: true,
                    showLabels: true,
                    axisLabelStyle:
                        GaugeTextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
            ),
          ),
          // KWH gauge widget
          Container(
            height: 200,
            width: 200,
            child: Card(
              color: Colors.amber[900],
              child: Container(
                  child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 2000,
                title: GaugeTitle(
                    text: 'KWH', textStyle: TextStyle(color: Colors.white70)),
                axes: <RadialAxis>[
                  RadialAxis(
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        horizontalAlignment: GaugeAlignment.center,
                        widget: Text(
                          '${kWh} kWh',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                    pointers: <GaugePointer>[
                      MarkerPointer(
                        value: kWh,
                        markerOffset: -8,
                        enableAnimation: true,
                        animationDuration: 2000,
                        color: Colors.orange,
                      ),
                      RangePointer(
                        enableAnimation: true,
                        value: kWh,
                        width: 13,
                        gradient: const SweepGradient(colors: <Color>[
                          Color(0xFFFFB907),
                          Color(0xFFB74D1C)
                        ], stops: <double>[
                          0.25,
                          0.80
                        ]),
                      )
                    ],
                    minimum: 0,
                    maximum: 3,
                    startAngle: 170,
                    endAngle: 10,
                    interval: 3,
                    canScaleToFit: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 13,
                    ),
                    showTicks: false,
                    showFirstLabel: true,
                    showLastLabel: true,
                    showLabels: true,
                    axisLabelStyle:
                        GaugeTextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
