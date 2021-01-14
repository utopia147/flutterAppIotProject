import 'package:flutter/material.dart';
import 'package:projectcontrol_app/enum/device_screen_type.dart';
import 'package:projectcontrol_app/ui/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const ScreenTypeLayout(
      {Key key,
      @required this.mobile,
      @required this.tablet,
      @required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeInformation) {
      if (sizeInformation.deviceScreenType == DeviceScreenType.Tablet) {
        if (tablet != null) {
          print(tablet);
          return tablet;
        }
      }
      if (sizeInformation.deviceScreenType == DeviceScreenType.Desktop) {
        if (desktop != null) {
          print(desktop);
          return desktop;
        }
      }
      if (sizeInformation.deviceScreenType == DeviceScreenType.Mobile) {
        if (mobile != null) {
          return mobile;
        }
      }
      print(mobile);
      return Container(
        child: Text('Widget null'),
      );
    });
  }
}
