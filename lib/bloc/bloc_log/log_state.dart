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
  final List<LogsData> logsData;

  LogFetchedSuccess(this.logsData);

  @override
  List<Object> get props => [logsData];
}

class LogError extends LogState {
  final String errorMsg;

  LogError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
