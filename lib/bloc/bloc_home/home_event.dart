part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SendNodeMCU extends HomeEvent {
  final int addNode;
  SendNodeMCU(this.addNode);
}

class AddNodeMCU extends HomeEvent {}

class DeleteNodeMCU extends HomeEvent {
  final nodeID;

  DeleteNodeMCU(this.nodeID);
}

class ConfirmDelete extends HomeEvent {
  final String nodeID;

  ConfirmDelete(this.nodeID);
}

class EditNodeMCU extends HomeEvent {
  final Map<String, dynamic> oldData;
  EditNodeMCU(this.oldData);
}

class SendEditNodeMCUApi extends HomeEvent {
  final String nodeID;
  final String editNodemcuProject;
  final String editNodemcuLocation;

  SendEditNodeMCUApi(
      this.nodeID, this.editNodemcuProject, this.editNodemcuLocation);
}

class SendAddNodeMCU extends HomeEvent {
  final String nodemcuProject;
  final String nodemcuLocation;
  final String nodemcuStatus;

  SendAddNodeMCU(this.nodemcuProject, this.nodemcuLocation, this.nodemcuStatus);
}

class LoadDataAPI extends HomeEvent {}
