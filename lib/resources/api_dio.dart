import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:projectcontrol_app/model/logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUri = 'http://192.168.0.108:3000/';

class ApiProvider {
  SharedPreferences prefer;
  static BaseOptions options = BaseOptions(
    baseUrl: baseUri,
    connectTimeout: 3000,
    receiveTimeout: 5000,
    validateStatus: (code) {
      if (code >= 200) {
        return true;
      }
    },
  );
  Dio dio = Dio(options);

  String token;

  Future<Map<String, dynamic>> loginApp(path, data) async {
    prefer = await SharedPreferences.getInstance();
    var res = await dio.post(path, data: data);
    if (res.statusCode == 200) {
      prefer.setString('token', res.data['Token']);
      print(res.data);
      return res.data;
    } else {
      print(res.data);
      return null;
    }
  }

  Future<dynamic> getApiClient(path) async {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      prefer = await SharedPreferences.getInstance();
      token = prefer.getString('token');
      options.headers = {"Authorization": "Bearer $token"};
      dio.interceptors.requestLock.unlock();
      return options; //continue
    }));

    var res = await dio.get(path);
    // print(res.data);
    if (res.statusCode == 200) {
      return res.data;
    }
  }

  Future<List<LogsData>> getLogsData(path) async {
    try {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (Options options) async {
        prefer = await SharedPreferences.getInstance();
        token = prefer.getString('token');
        options.headers = {"Authorization": "Bearer $token"};
        dio.interceptors.requestLock.unlock();
        return options; //continue
      }));

      Response<String> res = await dio.get(path);
      // print(res.data);
      if (res.statusCode == 200) {
        List<LogsData> _logsData = logsDataFromJson(res.data);
        return _logsData;
      }
    } catch (e) {
      print('FetchLogDataError:$e');
    }
  }

  Future<dynamic> registerApiClient(path, data) async {
    var res = await dio.post(path, data: data);
    // print(res.request.contentType);
    // print(res.statusCode);
    // print(res.headers);
    // print(res.request.headers);
    // print(res.request.data);
    print(res.request.data);
    print(res.data);
    return res.data;
  }

  Future<dynamic> postApiClient(path, data) async {
    prefer = await SharedPreferences.getInstance();
    token = prefer.getString('token');
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      };

      return options; //continue
    }));

    var res = await dio.post(path, data: data);
    // print(res.request.contentType);
    // print(res.statusCode);
    // print(res.headers);
    // print(res.request.headers);
    // print(res.request.data);
    print(res.request.data);
    print(res.data);
    return res.data;
  }

  Future<dynamic> updateApiClient(path, data) async {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      prefer = await SharedPreferences.getInstance();
      token = prefer.getString('token');
      options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/x-www-form-urlencoded",
      };
      dio.interceptors.requestLock.unlock();
      return options; //continue
    }));
    var res = await dio.put(path, data: data);

    return res.data;
  }

  Future<dynamic> deleteApiClient(path) async {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      prefer = await SharedPreferences.getInstance();
      token = prefer.getString('token');
      options.headers = {"Authorization": "Bearer $token"};
      dio.interceptors.requestLock.unlock();
      return options; //continue
    }));
    var res = await dio.delete(path);
    return res.data;
  }
}
