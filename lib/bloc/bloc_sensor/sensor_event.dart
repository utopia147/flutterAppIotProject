part of 'sensor_bloc.dart';

@immutable
abstract class SensorEvent {}

class StreamSensor extends SensorEvent {
  var response;
  StreamSensor(this.response);
}

class LoadDataSensor extends SensorEvent {
  final String sensors;
  LoadDataSensor(this.sensors);
}

class SendAddSensorData extends SensorEvent {
  final String nodemcuid;
  final String sensorname;

  SendAddSensorData(this.nodemcuid, this.sensorname);
}

class AddSensorData extends SensorEvent {}

class DeleteSensor extends SensorEvent {
  final String sensorID;

  DeleteSensor(this.sensorID);
}

class ConfirmDelete extends SensorEvent {
  final String sensorID;

  ConfirmDelete(this.sensorID);
}

class ResumeStream extends SensorEvent {}
