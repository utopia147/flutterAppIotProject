import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SoilMoistrueGaugeWidget extends StatelessWidget {
  const SoilMoistrueGaugeWidget({
    Key key,
    @required this.no,
    @required this.soilMoistureVal,
  }) : super(key: key);

  final int no;
  final double soilMoistureVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
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
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
                          colors: <Color>[Color(0xFF424242), Color(0xFF212121)],
                          stops: <double>[0.25, 0.75]),
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
    );
  }
}
