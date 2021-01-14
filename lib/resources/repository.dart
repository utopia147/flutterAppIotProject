import 'package:projectcontrol_app/model/chart_logs.dart';
import 'package:projectcontrol_app/model/logs.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'dart:convert' as convert;

class Repository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<ChartLogs>> fetchChartLogsData(category) async {
    try {
      String path = 'api/log/$category';
      var _fetchLogsData = await _apiProvider.getLogsData(path);
      print('Response = ${_fetchLogsData[0].createdAt}');

      List<ChartLogs> _fetchchartLogs = [];
      for (var logsData in _fetchLogsData) {
        _fetchchartLogs.add(ChartLogs(logsData.data, logsData.createdAt));
      }

      return _fetchchartLogs;
    } catch (e) {
      print('Error:$e');
    }
  }
}
