import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_log/log_bloc.dart';
import 'package:projectcontrol_app/model/chart_logs.dart';
import 'package:projectcontrol_app/model/logs.dart';
import 'package:projectcontrol_app/view/state_widget/error_state.dart';
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
    var _children = <Widget>[];
    _buildChartBarDHT(chartsLogsData) {
      return Container(
        color: Colors.white,
        child: SfCartesianChart(
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          primaryXAxis: NumericAxis(plotOffset: 0),
          title: ChartTitle(
              text: 'DHT Data Resources',
              textStyle: TextStyle(color: Colors.black87)),
          enableSideBySideSeriesPlacement: true,
          series: <ChartSeries<ChartLogs, int>>[
            ColumnSeries<ChartLogs, int>(
              name: 'Temperature',
              xAxisName: 'วันที่',
              yAxisName: 'ค่าอุณหภูมิ',
              enableTooltip: true,
              animationDuration: 3000,
              color: Colors.redAccent,
              dataSource: chartsLogsData,
              xValueMapper: (ChartLogs logs, _) =>
                  logs.dateTime.millisecondsSinceEpoch,
              yValueMapper: (ChartLogs logs, _) => logs.data[0],
            ),
            ColumnSeries<ChartLogs, int>(
              name: 'Humidity',
              enableTooltip: true,
              animationDuration: 5000,
              color: Colors.blueAccent,
              dataSource: chartsLogsData,
              xValueMapper: (ChartLogs logs, _) =>
                  logs.dateTime.millisecondsSinceEpoch,
              yValueMapper: (ChartLogs logs, _) => logs.data[1],
            )
          ],
          onAxisLabelRender: (axisLabelRenderArgs) {
            // print(axisLabelRenderArgs.text);
            if (axisLabelRenderArgs.axisName == 'primaryXAxis') {
              axisLabelRenderArgs.text = DateTime.fromMillisecondsSinceEpoch(
                          axisLabelRenderArgs.value.toInt())
                      .day
                      .toString() +
                  '/' +
                  DateTime.fromMillisecondsSinceEpoch(
                          axisLabelRenderArgs.value.toInt())
                      .month
                      .toString() +
                  '/' +
                  DateTime.fromMillisecondsSinceEpoch(
                          axisLabelRenderArgs.value.toInt())
                      .year
                      .toString()
                      .substring(2);
            }
          },
          onTooltipRender: (tooltipArgs) {
            var strMilliSec = tooltipArgs.text.substring(0, 14);
            var intMilliSec = int.parse(strMilliSec);
            var dateTime = DateTime.fromMillisecondsSinceEpoch(intMilliSec);

            var dataVal = tooltipArgs.text.substring(14);
            String _tooltipArgs =
                'ณ วันที่ ${dateTime.day}/${dateTime.month}/${dateTime.year} ค่าเฉลี่ย$dataVal';

            tooltipArgs.text = _tooltipArgs;
          },
        ),
      );
    }

    return BlocConsumer(
      cubit: logBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LogInitial) {
          logBloc.add(LogFetchedData(category, DateTime.now().year.toInt(),
              DateTime.now().month.toInt()));
        } else if (state is LogFetchedLoading) {
          _children = <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ];
        } else if (state is LogFetchedSuccess) {
          List<LogsData> chartsLogsData = state.logsData;
          switch (category) {
            case 'DHT':
              _children = <Widget>[
                _buildChartBarDHT(chartsLogsData),
                Card(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        color: Colors.amberAccent,
                      )
                    ],
                  ),
                )
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
        } else if (state is LogFetchedFailure) {
          _children = <Widget>[
            Container(
              height: 200,
              color: Colors.red,
            )
          ];
        } else if (state is LogError) {
          _children = <Widget>[
            ErrorWidgetState(
              msg: state.errorMsg,
              onPressed: null,
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
