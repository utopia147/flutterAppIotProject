import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projectcontrol_app/model/sensor.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';
import 'package:projectcontrol_app/stream_api/stream_data.dart';

part 'sensor_event.dart';
part 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final StreamData _streamData;
  StreamSubscription _streamDataSubscription;
  SensorBloc(this._streamData) : super(SensorInitial());

  @override
  Stream<SensorState> mapEventToState(
    SensorEvent event,
  ) async* {
    if (event is LoadDataSensor) {
      yield* _mapLoadDataSensorToState(event);
    } else if (event is StreamSensor) {
      yield* _mapStreamSensorToState(event);
    } else if (event is ResumeStream) {
      _streamDataSubscription?.resume();
    } else if (event is AddSensorData) {
      yield* _mapAddSensorDataToState();
    } else if (event is SendAddSensorData) {
      yield* _mapSendAddSensorDataToState(event);
    } else if (event is DeleteSensor) {
      yield* _mapDeleteSensorToState(event);
    } else if (event is ConfirmDelete) {
      yield* _mapConfirmDeleteToState(event);
    }
  }

  @override
  Future<void> close() {
    _streamDataSubscription?.cancel();
    return super.close();
  }

  Stream<SensorState> _mapLoadDataSensorToState(event) async* {
    try {
      _streamDataSubscription?.cancel();
      String sensors = event.sensors;
      String pathApi = 'api/sensor/$sensors';
      yield LoadingStreamState();
      await Future.delayed(Duration(seconds: 2));
      var response = await ApiProvider().getApiClient(pathApi);
      if (response.length != 0) {
        print(response);
        yield LoadedStreamState(response);

        _streamDataSubscription = _streamData
            .streamSensor(pathApi)
            .listen((res) => add(StreamSensor(res)));
      } else {
        yield LoadedDataSensorEmpty();
      }
    } catch (e) {
      yield ErrorSensorState(e.toString());
    }
  }

  Stream<SensorState> _mapStreamSensorToState(event) async* {
    try {
      if (event.response.length != 0) {
        yield LoadedStreamState(event.response);
      } else {
        yield LoadedDataSensorEmpty();
      }
    } catch (e) {
      yield ErrorSensorState(e.toString());
    }
  }

  Stream<SensorState> _mapAddSensorDataToState() async* {
    try {
      _streamDataSubscription?.pause();
      String path = 'api/nodemcu';
      var response = await ApiProvider().getApiClient(path);
      if (response.length != 0) {
        yield AddSensorState(response);
      } else {
        yield AlertSensorState('กรุณาเพิ่ม NodeMCU ก่อน');
      }
    } catch (e) {
      yield ErrorSensorState(e.toString());
    }
  }

  Stream<SensorState> _mapSendAddSensorDataToState(event) async* {
    try {
      String path = 'api/sensor/';
      var defaultSensorval;
      if (event.sensorname == 'DHT' ||
          event.sensorname == 'Voltage detection') {
        defaultSensorval = [0, 0];
      } else if (event.sensorname == 'Soil Moisture' ||
          event.sensorname == 'Ultrasonic Distance') {
        defaultSensorval = [0];
      }
      SensorModel sensorModel = SensorModel(
          nodemcuid: event.nodemcuid,
          sensorname: event.sensorname,
          sensorval: defaultSensorval);

      var jsonData = sensorModel.toJson();
      print(jsonData);
      var response = await ApiProvider().postApiClient(path, jsonData);
      if (response['suscess'] != null) {
        yield SendAddSensorDoneState();
      }
    } catch (e) {
      yield ErrorSensorState(e.toString());
    }
  }

  Stream<SensorState> _mapDeleteSensorToState(event) async* {
    try {
      _streamDataSubscription?.pause();
      yield DeleteConfirmState(event.sensorID);
    } catch (e) {
      yield ErrorSensorState(e.toString());
    }
  }

  Stream<SensorState> _mapConfirmDeleteToState(event) async* {
    try {
      String pathApi = 'api/sensor/' + event.sensorID;
      var responseDel = await ApiProvider().deleteApiClient(pathApi);
      if (responseDel['status'] != null) {
        _streamDataSubscription?.resume();
      }
    } catch (e) {
      yield ErrorSensorState(e.toString());
    }
  }
}
