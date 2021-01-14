part of 'relay_bloc.dart';

@immutable
abstract class RelayEvent {}

class LoadRelayData extends RelayEvent {}

class UpdateRelayData extends RelayEvent {}

class SendRelayStatus extends RelayEvent {
  final String channelid;
  final bool status;

  SendRelayStatus(this.channelid, this.status);
}

class AddRelayData extends RelayEvent {}

class DeleteRelayData extends RelayEvent {
  final String channelId;

  DeleteRelayData(this.channelId);
}

class EditRelayData extends RelayEvent {
  final Map oldData;

  EditRelayData(this.oldData);
}

class SendAddRelayData extends RelayEvent {
  final String nodemcuid;
  final String channelname;
  final bool status;
  final bool channelstatus;

  SendAddRelayData(
      this.nodemcuid, this.channelname, this.status, this.channelstatus);
}

class SendEditRelayData extends RelayEvent {
  final String editChannelid;
  final String editNodemcuid;
  final String editChannelname;

  SendEditRelayData(
      this.editChannelid, this.editNodemcuid, this.editChannelname);
}
