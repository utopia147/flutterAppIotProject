part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadDataAPIState extends HomeState {}

class LoadedHomeState extends HomeState {
  var response;
  LoadedHomeState(this.response);
}

class LoadedNodeNull extends HomeState {}

class AddNodeMCUState extends HomeState {}

class EditNodeMCUState extends HomeState {
  final Map<String, dynamic> oldDataState;

  EditNodeMCUState(this.oldDataState);
}

class AddSucessfulState extends HomeState {}

class AlertDeleteNodeMCUState extends HomeState {
  final nodeID;

  AlertDeleteNodeMCUState(this.nodeID);
}

class DeleteSucessfulState extends HomeState {}

class EditSucessfulState extends HomeState {}

class ErrorHomeState extends HomeState {
  final errorMsg;

  ErrorHomeState(this.errorMsg);
}
