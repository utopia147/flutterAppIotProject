import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectcontrol_app/model/chart_logs.dart';
import 'package:projectcontrol_app/model/logs.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:projectcontrol_app/resources/repository.dart';
import 'package:projectcontrol_app/stream_api/stream_data.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final Repository _repository;
  final StreamData _streamData;
  StreamSubscription _streamDataSubscription;
  LogBloc(
    this._repository,
    this._streamData,
  ) : super(LogInitial());

  @override
  Stream<LogState> mapEventToState(
    LogEvent event,
  ) async* {
    if (event is LogFetchedData) {
      yield* _mapLogFetchedDataToState(event);
    }
  }

  @override
  Future<void> close() {
    _streamDataSubscription?.cancel();
    return super.close();
  }

  Stream<LogState> _mapLogFetchedDataToState(event) async* {
    try {
      print('Log:${event.category}');
      yield LogFetchedLoading();
      await Future.delayed(Duration(seconds: 2));
      String category = event.category;
      List<ChartLogs> chartLogs =
          await _repository.fetchChartLogsData(category);

      if (chartLogs.length != 0) {
        print('Logs Fetched Done');

        yield LogFetchedSuccess(chartLogs);
      } else {
        print('Log Fetched Failed');
        yield LogFetchedFailure();
      }
    } catch (e) {}
  }
}
