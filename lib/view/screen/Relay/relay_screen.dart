import 'package:flutter/material.dart';
import 'package:projectcontrol_app/ui/orientation_layout.dart';
import 'package:projectcontrol_app/ui/screen_type_layout.dart';
import 'package:projectcontrol_app/view/screen/Relay/relay_screen_mobile.dart';

class RelayScreen extends StatelessWidget {
  const RelayScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: RelayScreenMobile(),
      tablet: null,
      desktop: null,
    );
  }
}
