import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';

part 'relay_event.dart';
part 'relay_state.dart';

class RelayBloc extends Bloc<RelayEvent, RelayState> {
  RelayBloc() : super(RelayInitial());

  @override
  Stream<RelayState> mapEventToState(
    RelayEvent event,
  ) async* {
    if (event is LoadRelayData) {
      yield* _mapLoadRelayDataToState();
    } else if (event is SendRelayStatus) {
      yield* _mapSendRelayStatusToState(event);
    } else if (event is AddRelayData) {
      yield* _mapAddRelayDataToState();
    } else if (event is SendAddRelayData) {
      yield* _mapSendAddRelayData(event);
    } else if (event is EditRelayData) {
      yield* _mapEditRelayDataToState(event);
    } else if (event is SendEditRelayData) {
      yield* _mapSendEditRelayDataToState(event);
    } else if (event is DeleteRelayData) {
      yield* _mapDeleteRelayDataToSatate(event);
    } else if (event is UpdateRelayData) {
      yield* _mapUpdateRelayDataToState();
    }
  }
}

Stream<RelayState> _mapLoadRelayDataToState() async* {
  try {
    yield LoadingApiState();
    await Future.delayed(Duration(seconds: 1));
    String pathApi = 'api/channel/';
    var response = await ApiProvider().getApiClient(pathApi);

    if (response.length != 0) {
      yield LoadedDataRelayState(response);
    } else {
      yield LoadedDataApiEmpty();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapUpdateRelayDataToState() async* {
  try {
    String pathApi = 'api/channel/';
    var response = await ApiProvider().getApiClient(pathApi);

    if (response.length != 0) {
      yield LoadedDataRelayState(response);
    } else {
      yield LoadedDataApiEmpty();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapSendRelayStatusToState(event) async* {
  try {
    String pathApi = 'api/channel/' + event.channelid;
    var data = {'status': event.status};
    print(data);
    var res = await ApiProvider().updateApiClient(pathApi, data);
    if (res['statusQuery'] != null) {
      print(res);
      yield SendRelayStatusSucessfulState();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapAddRelayDataToState() async* {
  try {
    String path = 'api/nodemcu';
    var response = await ApiProvider().getApiClient(path);
    if (response.length != 0) {
      yield AddRelayDataState(response);
    } else {
      yield AlertAddRelayState();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapSendAddRelayData(event) async* {
  try {
    String path = 'api/channel/';
    var data = {
      'nodemcuid': event.nodemcuid,
      'status': event.status,
      'channelname': event.channelname,
      'channelstatus': event.channelstatus,
    };
    var response = await ApiProvider().postApiClient(path, data);
    if (response['suscess'] != null) {
      yield SendRelayDataSucessState();
    } else {
      yield SendRelayDataFailedState();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapEditRelayDataToState(event) async* {
  try {
    String path = 'api/nodemcu';
    var response = await ApiProvider().getApiClient(path);
    yield EditRelayDataState(event.oldData, response);
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapSendEditRelayDataToState(event) async* {
  try {
    print('channelID:' + event.editChannelid);
    String pathApi = 'api/channel/editchannel/' + event.editChannelid;
    var data = {
      'nodemcuid': event.editNodemcuid,
      'channelname': event.editChannelname
    };
    print(data);
    var res = await ApiProvider().updateApiClient(pathApi, data);
    print(res);
    if (res['statusQuery'] != null) {
      yield SendRelayDataSucessState();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}

Stream<RelayState> _mapDeleteRelayDataToSatate(event) async* {
  try {
    print('channelID:' + event.channelId);
    String pathDelApi = 'api/channel/' + event.channelId;
    var res = await ApiProvider().deleteApiClient(pathDelApi);
    print(res);
    if (res['status'] != null) {
      yield SendRelayDataSucessState();
    }
  } catch (e) {
    yield ErrorRelayState(e.toString());
  }
}
