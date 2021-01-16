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
      // print('Response = ${_fetchLogsData[0].createdAt}');

      // List<ChartLogs> _fetchchartLogs = [];
      // for (var logsData in _fetchLogsData) {
      //   var dateTime = new DateTime(logsData.createdAt.year,
      //       logsData.createdAt.month, logsData.createdAt.day, 17);
      //   _fetchchartLogs.add(ChartLogs(logsData.data, dateTime));
      // }

      return _fetchLogsData;
    } catch (e) {
      print('Error:$e');
    }
  }
}
