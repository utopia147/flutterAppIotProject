import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class UltrasonicGaugeWidget extends StatelessWidget {
  const UltrasonicGaugeWidget({
    Key key,
    @required this.cm,
  }) : super(key: key);

  final double cm;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.grey[850],
        child: Container(
            child: SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 2000,
          title: GaugeTitle(
              text: 'DISTANCE', textStyle: TextStyle(color: Colors.white70)),
          axes: <RadialAxis>[
            RadialAxis(
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  positionFactor: 0.1,
                  horizontalAlignment: GaugeAlignment.center,
                  widget: Text(
                    '${cm} CM',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                )
              ],
              pointers: <GaugePointer>[
                MarkerPointer(
                  value: cm,
                  markerOffset: -8,
                  enableAnimation: true,
                  animationDuration: 2000,
                ),
                RangePointer(
                  enableAnimation: true,
                  value: cm,
                  width: 13,
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xFF07FF83), Color(0xFF079730)],
                      stops: <double>[0.25, 0.80]),
                )
              ],
              minimum: 0,
              maximum: 200,
              startAngle: 170,
              endAngle: 10,
              interval: 200,
              canScaleToFit: true,
              axisLineStyle: AxisLineStyle(
                thickness: 13,
              ),
              showTicks: false,
              showFirstLabel: true,
              showLastLabel: true,
              showLabels: true,
              axisLabelStyle: GaugeTextStyle(fontSize: 10, color: Colors.white),
            ),
          ],
        )),
      ),
    );
  }
}
