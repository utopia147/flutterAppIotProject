import 'package:flutter/material.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_mobile.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_tablet.dart';

class AppDrawer extends StatelessWidget {
  final int selected;
  const AppDrawer({Key key, @required this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        landscape: AppDrawerMobileLandscape(selected),
        portrait: AppDrawerMobilePortrait(selected),
      ),
      tablet: OrientationLayout(
        landscape: AppDrawerTabletLandscape(),
        portrait: AppDrawerTabletPortrait(),
      ),
      desktop: null,
    );
  }
}
