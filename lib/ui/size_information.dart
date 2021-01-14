import 'package:flutter/material.dart';
import 'package:projectcontrol_app/enum/device_screen_type.dart';

class SizeInformation {
  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  SizeInformation(
      {this.orientation,
      this.deviceScreenType,
      this.screenSize,
      this.localWidgetSize});

  @override
  String toString() {
    // TODO: implement toString
    return 'Orientation:$orientation | DeviceScreenType:$deviceScreenType | ScreenSize :$screenSize | LocalWidgetSize:$localWidgetSize';
  }
}
