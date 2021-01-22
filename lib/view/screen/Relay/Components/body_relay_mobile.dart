import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/Consitants.dart';
import 'package:projectcontrol_app/bloc/bloc_relay/relay_bloc.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Relay/relay_screen.dart';
import 'package:projectcontrol_app/view/state_widget/add_widget.dart';
import 'package:projectcontrol_app/view/state_widget/alert_state.dart';
import 'package:projectcontrol_app/view/state_widget/empty_state.dart';
import 'package:projectcontrol_app/view/state_widget/error_state.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer.dart';
import 'package:projectcontrol_app/view/widget/Form/form_relay.dart';

class BodyRelayPortrait extends StatelessWidget {
  BodyRelayPortrait({Key key}) : super(key: key);
  RelayBloc _relayBloc;

  var _isSwitched;
  var status;
  var channelid;
  var relayWidget;
  var newValue;
  @override
  Widget build(BuildContext context) {
    _relayBloc = BlocProvider.of<RelayBloc>(context);

    return Stack(
      children: [
        BlocConsumer<RelayBloc, RelayState>(
            listener: (context, state) {
              if (state is AddRelayDataState) {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FormAddRelay(
                            relayBloc: _relayBloc, nodemcuData: state.res)));
              } else if (state is EditRelayDataState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FormEditRelay(
                        relayBloc: _relayBloc,
                        oldDataRelay: state.oldData,
                        nodeMCU: state.nodeMCU),
                  ),
                );
              }
              if (state is SendRelayDataSucessState) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => RelayScreen()),
                    (Route<dynamic> route) => false);
              } else if (state is AlertAddRelayState) {
                return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) => AlertDialogStateWidget(
                          alertHeadline: 'ไม่สามารถาเพิ่มเซ็นเซอร์ได้',
                          alertMsg: 'คุณต้องเพิ่ม NodeMCU ก่อน',
                          goToMenu: 'ไปที่ NodeMCU',
                          goToOnPressed: () => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomeScreen()),
                                  (Route<dynamic> route) => false),
                          cancelMenu: 'ยกเลิก',
                          cancelOnPressed: () {
                            Navigator.of(context).pop();
                          },
                        ));
              }
            },
            cubit: _relayBloc,
            builder: (context, state) {
              if (state is RelayInitial) {
                _relayBloc.add(LoadRelayData());
                return SizedBox();
              } else if (state is LoadedDataRelayState) {
                relayWidget = GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: MediaQuery.of(context).size.height /
                          1 /
                          MediaQuery.of(context).size.width),
                  itemCount: state.payload.length,
                  itemBuilder: (BuildContext context, int index) {
                    void _choicesAction(String choice) {
                      if (choice == 'Edit') {
                        _relayBloc.add(EditRelayData(state.payload[index]));
                      } else if (choice == 'Delete') {
                        String channelId = state.payload[index]['_id'];
                        // print(index);
                        // print(nodeID);
                        _relayBloc.add(DeleteRelayData(channelId));
                      }
                      print(choice);
                    }

                    status = state.payload[index]['status'];

                    // print(channelid);
                    // print('status:$status');
                    return Container(
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                              title: Text(
                                'Channel ที่${index + 1}',
                                style: TextStyle(fontSize: 14),
                              ),
                              subtitle: Text(
                                  'เปิด-ปิด ${state.payload[index]["channelname"]}'),
                              trailing: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.pinkAccent,
                                  ),
                                  onSelected: _choicesAction,
                                  itemBuilder: (BuildContext context) {
                                    return Consitants.choices.map((choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  }),
                            ),
                            Transform.scale(
                              scale: 1.5,
                              child: Switch(
                                  hoverColor: Colors.red,
                                  activeColor: Colors.greenAccent,
                                  value: status,
                                  onChanged: (value) {
                                    newValue = value;
                                    _relayBloc.add(SendRelayStatus(
                                        state.payload[index]['_id'], newValue));
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is SendRelayStatusSucessfulState) {
                _relayBloc.add(UpdateRelayData());
              } else if (state is LoadedDataApiEmpty) {
                relayWidget = EmptyDataWidget(
                  heading: 'ไม่พบข้อมูล Relay Channel',
                  content:
                      'กรุณาเพิ่มข้อมูล Relay Channel โดยการ\nกดไปที่ปุ่ม + มุมล่างขวา',
                );
              } else if (state is LoadingApiState) {
                relayWidget = Center(
                  child: RefreshProgressIndicator(),
                );
              } else if (state is ErrorRelayState) {
                relayWidget = ErrorWidgetState(
                    msg: '${state.msg}',
                    onPressed: () => _relayBloc.add(LoadRelayData()));
              }
              return relayWidget;
            }),
        AddWidget(
            tooltip: 'เพิ่มอุปกรณ์ควบคุม',
            onPressed: () => _relayBloc.add(AddRelayData())),
      ],
    );
  }
}

class BodyRelayLandScape extends StatelessWidget {
  final int selectedAppDrawer;
  BodyRelayLandScape({Key key, @required this.selectedAppDrawer})
      : super(key: key);
  RelayBloc _relayBloc;

  var status;
  var channelid;
  var relayWidget;
  var newValue;
  @override
  Widget build(BuildContext context) {
    _relayBloc = BlocProvider.of<RelayBloc>(context);
    return Row(
      children: [
        Expanded(
          child: AppDrawer(
            selected: selectedAppDrawer,
          ),
        ),
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              BlocConsumer<RelayBloc, RelayState>(
                  listener: (context, state) {
                    if (state is AddRelayDataState) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => FormAddRelay(
                                  relayBloc: _relayBloc,
                                  nodemcuData: state.res)));
                    } else if (state is EditRelayDataState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => FormEditRelay(
                              relayBloc: _relayBloc,
                              oldDataRelay: state.oldData,
                              nodeMCU: state.nodeMCU),
                        ),
                      );
                    }
                    if (state is SendRelayDataSucessState) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => RelayScreen()),
                          (Route<dynamic> route) => false);
                    } else if (state is AlertAddRelayState) {
                      return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (dialogContext) => AlertDialogStateWidget(
                                alertHeadline: 'ไม่สามารถาเพิ่มเซ็นเซอร์ได้',
                                alertMsg: 'คุณต้องเพิ่ม NodeMCU ก่อน',
                                goToMenu: 'ไปที่ NodeMCU',
                                goToOnPressed: () => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomeScreen()),
                                        (Route<dynamic> route) => false),
                                cancelMenu: 'ยกเลิก',
                                cancelOnPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ));
                    }
                  },
                  cubit: _relayBloc,
                  builder: (context, state) {
                    if (state is RelayInitial) {
                      _relayBloc.add(LoadRelayData());
                      return SizedBox();
                    } else if (state is LoadedDataRelayState) {
                      relayWidget = GridView.builder(
                        padding: EdgeInsets.only(top: 45),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    1.8 /
                                    MediaQuery.of(context).size.height),
                        itemCount: state.payload.length,
                        itemBuilder: (BuildContext context, int index) {
                          void _choicesAction(String choice) {
                            if (choice == 'Edit') {
                              _relayBloc
                                  .add(EditRelayData(state.payload[index]));
                            } else if (choice == 'Delete') {
                              String channelId = state.payload[index]['_id'];
                              // print(index);
                              // print(nodeID);
                              _relayBloc.add(DeleteRelayData(channelId));
                            }
                            print(choice);
                          }

                          status = state.payload[index]['status'];
                          channelid = state.payload[index]['_id'];

                          return Container(
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Channel ที่${index + 1}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    subtitle: Text(
                                        'เปิด-ปิด ${state.payload[index]["channelname"]}'),
                                    trailing: PopupMenuButton<String>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.pinkAccent,
                                        ),
                                        onSelected: _choicesAction,
                                        itemBuilder: (BuildContext context) {
                                          return Consitants.choices
                                              .map((choice) {
                                            return PopupMenuItem<String>(
                                              value: choice,
                                              child: Text(choice),
                                            );
                                          }).toList();
                                        }),
                                  ),
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Switch(
                                        hoverColor: Colors.red,
                                        activeColor: Colors.greenAccent,
                                        value: status,
                                        onChanged: (value) {
                                          newValue = value;
                                          _relayBloc.add(SendRelayStatus(
                                              state.payload[index]['_id'],
                                              newValue));
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is SendRelayStatusSucessfulState) {
                      _relayBloc.add(UpdateRelayData());
                    } else if (state is LoadedDataApiEmpty) {
                      relayWidget = EmptyDataWidget(
                        heading: 'ไม่พบข้อมูล Relay Channel',
                        content:
                            'กรุณาเพิ่มข้อมูล Relay Channel โดยการ\nกดไปที่ปุ่ม + มุมล่างขวา',
                      );
                    } else if (state is LoadingApiState) {
                      relayWidget = Center(
                        child: RefreshProgressIndicator(),
                      );
                    } else if (state is ErrorRelayState) {
                      relayWidget = ErrorWidgetState(
                          msg: '${state.msg}',
                          onPressed: () => _relayBloc.add(LoadRelayData()));
                    }
                    return relayWidget;
                  }),
              AddWidget(
                  tooltip: 'เพิ่มอุปกรณ์ควบคุม',
                  onPressed: () => _relayBloc.add(AddRelayData()))
            ],
          ),
        ),
      ],
    );
  }
}
