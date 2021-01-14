import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectcontrol_app/model/photos.dart';
import 'package:projectcontrol_app/model/reqlogin.dart';
import 'package:toast/toast.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class NativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NativeState();
  }
}

class NativeState extends State<NativePage> {
  String base64;
  var images;
  List<Photo> photos;
  VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Native Toast'),
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text('Native Toast'),
              onPressed: () {
                Toast.show("คุณได้กด Native Toast", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
            ),
            RaisedButton(
              child: Text('Base 64'),
              onPressed: () async {
                ByteData bs = await rootBundle.load('images/logo.png');
                List<int> ls = bs.buffer.asUint8List();
                base64 = convert.base64Encode(ls);
                print(base64);
              },
            ),
            RaisedButton(
              child: Text('HTTP'),
              onPressed: () async {
                var req = ReqLogin();
                req.email = 'eve.holt@reqres.in';
                req.password = 'cityslicka111';
                var jsonReq = reqLoginToJson(req);
                print(jsonReq);
                var urlReq = 'https://reqres.in/api/login';
                var res = await http.post(urlReq, body: jsonReq, headers: {
                  HttpHeaders.contentTypeHeader: 'application/json'
                });
                print('Response status: ${res.statusCode}');
                print('Response body: ${res.body}');
              },
            ),
            RaisedButton(
              child: Text('Camera'),
              onPressed: () async {
                images =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                print(images);
                setState(() {});
              },
            ),
            RaisedButton(
              child: Text('Streaming Video'),
              onPressed: () {
                String url =
                    'https://www.radiantmediaplayer.com/media/bbb-360p.mp4';
                _controller = VideoPlayerController.network(url)
                  ..initialize().then((val) {
                    setState(() {
                      _controller.play();
                    });
                  });
              },
            ),
            (base64 != null) ? Text(base64) : Container(),
            (images != null)
                ? Image.file(
                    images,
                    width: 300,
                    height: 190,
                  )
                : Container(),
            (_controller != null && _controller.value.initialized)
                ? Chewie(
                    controller:
                        ChewieController(videoPlayerController: _controller),
                  )
                : Container(),
          ],
        ));
  }
}
