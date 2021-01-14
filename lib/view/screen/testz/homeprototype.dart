import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String args; //สร้าง constructor รับค่า arguments
  HomePage(String args) {
    this.args = args;
  }
  @override
  State<StatefulWidget> createState() => _HomePage(args); //ส่งค่า args
}

class _HomePage extends State<HomePage> {
  String args; //สร้าง constructor รับค่า arguments
  _HomePage(String args) {
    this.args = args;
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Project One'),
        ),
        body: Container(
          // margin: EdgeInsets.all(20.0), //ตั้งค่า margin ทุกด้าน
          // margin: MediaQuery.of(context)
          //     .padding, // เว้นระยะแถบด้านบนมือถือกรณีทำ full screen ไม่มี Appbar
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('password'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(args),
                ],
              ),
            ],
          ),
        ),
      );
}
