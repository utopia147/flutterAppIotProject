import 'package:flutter/cupertino.dart';
import 'package:projectcontrol_app/enum/device_screen_type.dart';

DeviceScreenType getDeviceScreenType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;

  double deviceWidth = mediaQuery.size.shortestSide;

  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }
  if (deviceWidth > 950) {
    print(deviceWidth);
    return DeviceScreenType.Desktop;
  }
  if (deviceWidth > 600) {
    print(deviceWidth);
    return DeviceScreenType.Tablet;
  }
  print(deviceWidth);
  return DeviceScreenType.Mobile;
}
