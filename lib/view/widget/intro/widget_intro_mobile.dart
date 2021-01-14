import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:projectcontrol_app/bloc/bloc_authen/authentication_bloc.dart';

class WidgetIntroMobile extends StatefulWidget {
  WidgetIntroMobile({
    Key key,
    @required this.authenticationBloc,
  }) : super(key: key);
  final AuthenticationBloc authenticationBloc;

  @override
  _WidgetIntroMobileState createState() => _WidgetIntroMobileState();
}

class _WidgetIntroMobileState extends State<WidgetIntroMobile> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: Colors.black,
                        image: DecorationImage(
                          image: const AssetImage('images/logo.png'),
                          fit: BoxFit.fill,
                        )),
                  )),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'PROJECT CONTROL',
                        style: TextStyle(
                          fontFamily: 'TH Sarabun New',
                          fontSize: 30,
                          color: const Color(0xfffe65c3),
                          letterSpacing: 0.9,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 307.0,
                      height: 211.0,
                      child: Text(
                        ' \nแอปพลิเคชั่นบนมือถือที่ทำขึ้นเพื่อให้บริการเชื่อมต่อกับ IoT platfrom \n\n',
                        style: TextStyle(
                          fontFamily: 'TH Sarabun New',
                          fontSize: 30,
                          color: const Color(0xFF525252),
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w700,
                          height: 1.1428571428571428,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () =>
                      widget.authenticationBloc.add(CheckAuthenEvent()),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withAlpha(225),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Center(
                        child: Text(
                          'Go to App',
                          style: TextStyle(
                            fontFamily: 'Lucida Handwriting',
                            fontSize: 20,
                            color: const Color(0xF1FFFFFF),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
