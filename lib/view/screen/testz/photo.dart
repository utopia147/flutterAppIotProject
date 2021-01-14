import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:projectcontrol_app/model/photos.dart';
import 'package:http/http.dart' as http;

class PhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoPage();
}

class _PhotoPage extends State<PhotoPage> {
  List<String> list = ['xxx', 'yyy', 'zzz'];
  List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    List<String> arg = ModalRoute.of(context)
        .settings
        .arguments; // รับค่าจาก Navigator.psuhNamed

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(children: <Widget>[
        RaisedButton(
            child: Text('ok'),
            onPressed: () {
              // print(arg);
              // var login = Login();
              // login.username = arg[0];
              // login.password = arg[1];
              // print(login);
              // String jsonStr = loginToJson(login); // แปลง OBject เป็น JSON
              // print(jsonStr);
              // var returnJson = loginFromJson(jsonStr); // แปลง JSON เป็น Object
              // print(returnJson.username);
            }),
        // color: Colors.orange[300],
        // child: Center(
        //   child: Column(
        //     children: list.where((element) => element != 'xxx').map((element) {
        //       //วนลูป widget และข้อมูล
        //       // if (element == 'yyy') { if แบบเดิม
        //       //   return Container();
        //       // } else {
        //       //   return Text(element);
        //       // }
        //       return Text(element);
        //     }).toList(),
        //   ),
        // ),
        RaisedButton(
          child: Text('GET DATA'),
          onPressed: () async {
            var url = 'https://jsonplaceholder.typicode.com/photos';
            var resGet = await http.get(url);
            print('Response status: ${resGet.statusCode}');
            print('Response body: ${resGet.body.length}');
            String photosJson = resGet.body;
            photos = photoFromJson(photosJson);
            print(photos.length);
          },
        ),
        RaisedButton(
          child: Text('Show DATA'),
          onPressed: () {
            setState(() {});
          },
        ),
        (photos != null)
            ? Column(
                children: photos.getRange(0, 100).map((photos) {
                  return Card(
                    child: ListTile(
                      title: Text(photos.title),
                      leading: Image.network(
                        photos.url,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                }).toList(),
              )
            : Container(),
      ]),
    );
  }
}
