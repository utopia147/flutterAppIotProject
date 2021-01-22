import 'package:projectcontrol_app/model/logs.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'dart:convert' as convert;

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<LogsData>> fetchChartLogsData(
      category, fetchYear, fetchMonth) async {
    try {
      String path = 'api/log/$category/$fetchYear/$fetchMonth';
      var _fetchLogsData = await _apiProvider.getLogsData(path);
      return _fetchLogsData;
    } catch (e) {
      print('Error:$e');
    }
  }
}
