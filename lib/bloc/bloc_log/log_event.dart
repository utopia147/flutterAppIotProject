part of 'log_bloc.dart';

abstract class LogEvent extends Equatable {
  const LogEvent();

  @override
  List<Object> get props => [];
}

class LogFetchedData extends LogEvent {
  final String category;
  LogFetchedData(this.category);
  @override
  List<Object> get props => [category];
}
