import 'package:projectcontrol_app/resources/api_dio.dart';

class StreamData {
  Stream streamSensor(String pathApi) {
    return Stream.periodic(Duration(minutes: 1), (_) async {
      var response = await ApiProvider().getApiClient(pathApi);
      return response;
    }).asyncMap((value) async => await value);
  }
}
