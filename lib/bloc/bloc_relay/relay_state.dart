part of 'relay_bloc.dart';

@immutable
abstract class RelayState {}

class RelayInitial extends RelayState {}

class LoadingApiState extends RelayState {}

class LoadedDataRelayState extends RelayState {
  final List payload;

  LoadedDataRelayState(this.payload);
}

class LoadedDataApiEmpty extends RelayState {}

class ErrorRelayState extends RelayState {
  final String msg;

  ErrorRelayState(this.msg);
}

class AddRelayDataState extends RelayState {
  final List<dynamic> res;

  AddRelayDataState(this.res);
}

class AlertAddRelayState extends RelayState {}

class EditRelayDataState extends RelayState {
  final Map oldData;
  final List nodeMCU;
  EditRelayDataState(this.oldData, this.nodeMCU);
}

class SendRelayStatusSucessfulState extends RelayState {}

class SendRelayDataSucessState extends RelayState {}

class SendRelayDataFailedState extends RelayState {}
