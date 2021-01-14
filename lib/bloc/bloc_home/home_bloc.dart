import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:projectcontrol_app/resources/api_dio.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is AddNodeMCU) {
      yield* _mapAddNodeMCUToState();
    } else if (event is LoadDataAPI) {
      yield* _mapLoadDataAPIToState();
    } else if (event is SendAddNodeMCU) {
      yield* _mapSendAddNodeMCUToState(event);
    } else if (event is EditNodeMCU) {
      yield* _mapEditNodeMCUToState(event);
    } else if (event is SendEditNodeMCUApi) {
      yield* _mapSendEditNodeMCUApiToState(event);
    } else if (event is DeleteNodeMCU) {
      yield* _mapDeleteNodeMCUToState(event);
    } else if (event is ConfirmDelete) {
      yield* _mapConfirmDeleteToState(event);
    }
  }
}

Stream<HomeState> _mapAddNodeMCUToState() async* {
  try {
    // yield LoadingHomeState();
    // await Future.delayed(Duration(seconds: 1));
    yield AddNodeMCUState();
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}

Stream<HomeState> _mapEditNodeMCUToState(event) async* {
  try {
    yield EditNodeMCUState(event.oldData);
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}

Stream<HomeState> _mapLoadDataAPIToState() async* {
  try {
    yield LoadingHomeState();
    await Future.delayed(Duration(milliseconds: 500));
    String path = 'api/nodemcu';
    var response = await ApiProvider().getApiClient(path);

    if (response.length == 0) {
      yield LoadedNodeNull();
    } else {
      yield LoadedHomeState(response);
    }
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}

Stream<HomeState> _mapSendAddNodeMCUToState(event) async* {
  try {
    print(event.nodemcuProject);
    print(event.nodemcuLocation);
    print(event.nodemcuStatus);
    String pathAdd = 'api/nodemcu/add';

    var data = {
      "nodemcuProject": event.nodemcuProject,
      "nodemcuLocation": event.nodemcuLocation,
      "nodemcuStatus": event.nodemcuStatus,
    };
    var postResponse = await ApiProvider().postApiClient(pathAdd, data);

    if (postResponse["suscess"] != null) {
      yield AddSucessfulState();
    } else {
      ErrorHomeState("ลองอีกครั้ง");
    }
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}

Stream<HomeState> _mapDeleteNodeMCUToState(event) async* {
  try {
    yield AlertDeleteNodeMCUState(event.nodeID);
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}

Stream<HomeState> _mapConfirmDeleteToState(event) async* {
  try {
    String pathApiDel = 'api/nodemcu/' + event.nodeID;
    var deleteResponse = await ApiProvider().deleteApiClient(pathApiDel);
    print(deleteResponse);
    if (deleteResponse['status'] == 'Done') {
      yield DeleteSucessfulState();
    }
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}

Stream<HomeState> _mapSendEditNodeMCUApiToState(event) async* {
  try {
    print(event.nodeID);
    print(event.editNodemcuProject);
    print(event.editNodemcuLocation);
    String pathApiEdit = 'api/nodemcu/' + event.nodeID;
    var data = {
      "nodemcuProject": event.editNodemcuProject,
      "nodemcuLocation": event.editNodemcuLocation,
    };
    var editResponse = await ApiProvider().updateApiClient(pathApiEdit, data);
    print(editResponse);
    if (editResponse['status'] != null) {
      yield EditSucessfulState();
    }
  } catch (e) {
    yield ErrorHomeState(e.toString());
  }
}
