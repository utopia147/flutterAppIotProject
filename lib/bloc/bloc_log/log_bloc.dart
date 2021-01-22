import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectcontrol_app/model/logs.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:projectcontrol_app/resources/api_repository.dart';
import 'package:projectcontrol_app/stream_api/stream_data.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final ApiRepository _apiRepository;
  LogBloc(
    this._apiRepository,
  ) : super(LogInitial());

  @override
  Stream<LogState> mapEventToState(
    LogEvent event,
  ) async* {
    if (event is LogFetchedData) {
      yield* _mapLogFetchedDataToState(event);
    }
  }

  Stream<LogState> _mapLogFetchedDataToState(event) async* {
    try {
      print('Log:${event.category}');
      yield LogFetchedLoading();
      await Future.delayed(Duration(milliseconds: 500));
      String category = event.category;
      int fetchYear = event.fetchYear;
      int fetchMonth = event.fetchMonth;
      List<LogsData> logsData = await _apiRepository.fetchChartLogsData(
          category, fetchYear, fetchMonth);

      if (logsData.length != 0) {
        yield LogFetchedSuccess(logsData);
      } else {
        yield LogFetchedFailure();
      }
    } catch (e) {
      yield LogError(e.toString());
    }
  }
}
