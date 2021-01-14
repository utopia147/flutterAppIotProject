part of 'log_bloc.dart';

abstract class LogState extends Equatable {
  const LogState();

  @override
  List<Object> get props => [];
}

class LogInitial extends LogState {}

class LogFetchedFailure extends LogState {}

class LogFetchedLoading extends LogState {}

class LogFetchedSuccess extends LogState {
  final List<ChartLogs> chartLogs;

  LogFetchedSuccess(this.chartLogs);

  @override
  List<Object> get props => [chartLogs];
}
