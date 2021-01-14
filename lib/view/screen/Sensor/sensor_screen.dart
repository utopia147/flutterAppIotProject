import 'package:flutter/material.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/screen/Sensor/Components/Mobile/sensor_screen_mobile.dart';

class SensorScreen extends StatelessWidget {
  const SensorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: SensorScreenMobile(), tablet: null, desktop: null);
  }
}
