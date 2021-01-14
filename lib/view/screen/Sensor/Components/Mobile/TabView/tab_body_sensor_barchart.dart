import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_log/log_bloc.dart';
import 'package:projectcontrol_app/model/chart_logs.dart';
import 'package:projectcontrol_app/model/logs.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TabBodySensorBarchart extends StatelessWidget {
  const TabBodySensorBarchart({
    Key key,
    @required this.category,
    @required this.logBloc,
  }) : super(key: key);

  final String category;
  final LogBloc logBloc;
  @override
  Widget build(BuildContext context) {
    List<ChartLogs> chartsLogsData = [
      ChartLogs(
        [60, 60],
        DateTime.parse('2021-01-06 00:41:03'),
      ),
      ChartLogs(
        [35, 40],
        DateTime.parse('2021-01-06 00:50:03'),
      ),
      ChartLogs(
        [33, 50],
        DateTime.parse('2021-01-06 00:59:03'),
      ),
    ];
    var _children = <Widget>[];
    return BlocConsumer(
      cubit: logBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LogInitial) {
          logBloc.add(LogFetchedData(category));
        } else if (state is LogFetchedLoading) {
          _children = <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ];
        } else if (state is LogFetchedSuccess) {
          // List<ChartLogs> chartsLogsData = state.chartLogs;
          print(state.chartLogs[0].data[0]);

          switch (category) {
            case 'DHT':
              _children = <Widget>[
                Container(
                    child: SfCartesianChart(
                  title: ChartTitle(text: 'DHT Data Resources'),
                  enableSideBySideSeriesPlacement: false,
                  series: <ChartSeries>[
                    ColumnSeries<ChartLogs, dynamic>(
                      dataSource: chartsLogsData,
                      xValueMapper: (ChartLogs logs, _) => logs.date,
                      yValueMapper: (ChartLogs logs, _) => logs.data[0],
                    ),
                    ColumnSeries<ChartLogs, dynamic>(
                      opacity: 0.9,
                      width: 0.4,
                      dataSource: chartsLogsData,
                      xValueMapper: (ChartLogs logs, _) => logs.date,
                      yValueMapper: (ChartLogs logs, _) => logs.data[1],
                    )
                  ],
                )),
              ];
              break;
            case 'Soil Moisture':
              _children = <Widget>[];
              break;
            case 'Voltage detection':
              _children = <Widget>[];
              break;
            case 'Ultrasonic Distance':
              _children = <Widget>[];
              break;
            default:
          }
          _children = <Widget>[];
        } else if (state is LogFetchedFailure) {
          _children = <Widget>[
            Container(
              height: 200,
              color: Colors.red,
            )
          ];
        }

        return Column(
          children: _children,
        );
      },
    );
  }
}
