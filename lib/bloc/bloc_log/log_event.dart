part of 'log_bloc.dart';

abstract class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object> get props => [];
}

class LogFetchedData extends LogEvent {
  final String category;
  final int fetchYear;
  final int fetchMonth;
  LogFetchedData(this.category, this.fetchYear, this.fetchMonth, );
  @override
  List<Object> get props => [category, fetchYear , fetchMonth];
}
