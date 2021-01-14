import 'package:flutter/material.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/responsive_builder.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/screen/testz/home_view_moblie.dart';
import 'package:projectcontrol_app/view/screen/testz/home_view_tablet.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        landscape: HomeMoblileLandScape(),
        portrait: HomeMobilePortrait(),
      ),
      tablet: OrientationLayout(
        landscape: HomeTabletLandScape(),
        portrait: HomeTabletPortrait(),
      ),
      desktop: null,
    );
  }
}
