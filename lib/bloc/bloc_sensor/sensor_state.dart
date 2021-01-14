part of 'sensor_bloc.dart';

@immutable
abstract class SensorState {}

class SensorInitial extends SensorState {}

class LoadingStreamState extends SensorState {}

class LoadedStreamState extends SensorState {
  final List response;

  LoadedStreamState(this.response);
}

class LoadedDataSensorEmpty extends SensorState {}

class AddSensorState extends SensorState {
  final List res;

  AddSensorState(this.res);
}

class SendAddSensorDoneState extends SensorState {}

class DeleteConfirmState extends SensorState {
  final String sensorID;

  DeleteConfirmState(this.sensorID);
}

class DeleteSuscessfulState extends SensorState {}

class ErrorSensorState extends SensorState {
  final String errMsg;

  ErrorSensorState(this.errMsg);
}

class AlertSensorState extends SensorState {
  final String alertMsg;

  AlertSensorState(this.alertMsg);
}
