import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //Attribute
  String url;
  var data;
  String userid;
  Map<String, String> headers = {};
  SharedPreferences sharedPreferences;

  // ignore: missing_return
  Future<dynamic> loginSession(url, data) async {
    var jsonLogin = convert.jsonEncode(data);
    http.Response response = await http.post(url, body: jsonLogin, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
    if (response.statusCode == 200) {
      sharedPreferences = await SharedPreferences.getInstance();
      Map<String, dynamic> mapRes = convert.jsonDecode(response.body);
      // print(mapRes);
      String token = mapRes["token"];
      String userid = mapRes["user"]["_id"];
      sharedPreferences.setString('token', token);
      sharedPreferences.setString('userid', userid);
      // print(token);
      // print(userid);

      return mapRes;
    }
    // headers = {'Cookie': response.headers['set-cookie']};
    // print(headers);

    if (response.statusCode == 302) {
      var containskey = response.headers.containsKey("location");
      print(containskey);

      if (containskey) {
        String ip = url.substring(0, 25);
        print(response.headers['location']);
        print(response.headers['set-cookie']);
        print(url);
        print(ip + response.headers['location']);
        http.Response res =
            await http.get(ip + response.headers['location'], headers: headers);
        print(res.statusCode);
        if (res.statusCode == 200) {
          print(headers);
          var data = convert.jsonDecode(res.body);
          Map<String, dynamic> rest = data;
          return rest;
        }
      }
    }
  }

  // ignore: missing_return
  Future<Map<String, dynamic>> getUser(url, userid) async {
    var req = url + userid;
    http.Response response = await http.get(req, headers: headers);
    if (response.statusCode == 200) {
      var userData = convert.jsonDecode(response.body);
      Map<String, dynamic> user = userData;
      return user;
    }
  }

  Future<dynamic> register(url, mapData) async {
    var jsonData = convert.jsonEncode(mapData);
    http.Response response = await http.post(url, body: jsonData, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> mapRes = convert.jsonDecode(response.body);
      // print(mapRes);
      return mapRes;
    } else {
      print(response.statusCode);
      return convert.jsonDecode(response.body);
    }
  }

  // ignore: missing_return
  Future<Map<String, dynamic>> nodeMcuApi() async {
    String url = 'http://192.168.0.103:3000/api/nodemcu';
    http.Response response = await http.get(url, headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> mapRes = convert.jsonDecode(response.body);

      return mapRes;
    } else {
      print(response.statusCode);
    }
  }
}
