import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:projectcontrol_app/bloc/bloc_log/log_bloc.dart';
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
          series: <ChartSeries<LogsData, dynamic>>[
            ColumnSeries<LogsData, dynamic>(
              name: 'Temperature',
              xAxisName: 'วันที่',
              yAxisName: 'ค่าอุณหภูมิ',
              enableTooltip: true,
              animationDuration: 3000,
              color: Colors.redAccent,
              dataSource: chartsLogsData,
              xValueMapper: (LogsData logs, _) {
                var _dateTime =
                    DateTime(logs.id.year, logs.id.month, logs.id.day);
                return _dateTime.millisecondsSinceEpoch;
              },
              yValueMapper: (LogsData logs, _) => logs.avgValue1,
            ),
            ColumnSeries<LogsData, dynamic>(
              name: 'Humidity',
              enableTooltip: true,
              animationDuration: 5000,
              color: Colors.blueAccent,
              dataSource: chartsLogsData,
              xValueMapper: (LogsData logs, _) {
                var _dateTime =
                    DateTime(logs.id.year, logs.id.month, logs.id.day);
                return _dateTime.millisecondsSinceEpoch;
              },
              yValueMapper: (LogsData logs, _) => logs.avgValue2,
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
            // print(tooltipArgs.text);
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
              child: RefreshProgressIndicator(),
            )
          ];
        } else if (state is LogFetchedSuccess) {
          List<LogsData> chartsLogsData = state.logsData;
          switch (category) {
            case 'DHT':
              _children = <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.calendar_today),
                      title: Text(
                        'ดูข้อมูล ณ ปี${state.logsData[0].id.year} เดือนที่${state.logsData[0].id.month}',
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_downward),
                      onTap: () {
                        return DatePicker.showDatePicker(
                          context,
                          pickerTheme:
                              DateTimePickerTheme(confirm: Text('ยืนยัน')),
                          initialDateTime: DateTime.now(),
                          dateFormat: 'MMMM-yyyy',
                          onConfirm: (date, index) {
                            print('Date:$date');
                            logBloc.add(LogFetchedData(
                                category, date.year, date.month));
                          },
                        );
                      },
                    ),
                  ),
                ),
                _buildChartBarDHT(chartsLogsData),
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
