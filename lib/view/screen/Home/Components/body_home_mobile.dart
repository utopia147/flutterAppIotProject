import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';

import 'package:projectcontrol_app/view/screen/Home/Components/card_nodemcu.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Home/home_mobile.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer.dart';
import 'package:projectcontrol_app/view/widget/AppDrawer/app_drawer_mobile.dart';
import 'package:projectcontrol_app/view/state_widget/add_widget.dart';
import 'package:projectcontrol_app/view/state_widget/alert_state.dart';
import 'package:projectcontrol_app/view/state_widget/empty_state.dart';
import 'package:projectcontrol_app/view/state_widget/error_state.dart';
import 'package:projectcontrol_app/view/widget/Form/form_nodemcu.dart';
import 'package:projectcontrol_app/view/widget/intro/widget_intro_mobile.dart';

class BodyHomeMobliePortrait extends StatelessWidget {
  HomeBloc _homeBloc;
  List nodeMCUList = [];
  TextEditingController nodemcuProject = TextEditingController();
  TextEditingController nodemcuLocation = TextEditingController();
  String nodemcuStatus = 'Disconnect';
  var sliverWidget = <Widget>[];
  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              snap: false,
              leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<HomeBloc, HomeState>(
              cubit: _homeBloc,
              listener: (context, state) {
                if (state is AddNodeMCUState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormAddNodeMCU(
                                homeBloc: _homeBloc,
                              )));
                } else if (state is EditNodeMCUState) {
                  var _oldDataNodeMCU = state.oldDataState;
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormEditNodeMCU(
                              homeBloc: _homeBloc,
                              oldDataNodeMCU: _oldDataNodeMCU)));
                } else if (state is AddSucessfulState ||
                    state is DeleteSucessfulState) {
                  return Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()),
                      (Route<dynamic> route) => false);
                } else if (state is AlertDeleteNodeMCUState) {
                  return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) => AlertDialogStateWidget(
                        alertHeadline: 'ยืนยัน',
                        alertMsg:
                            'จะทำการลบอุปกรณ์หรือเซ็นเซอร์ทั้งหมดที่คุณเชื่อมกับ NodeMCU ตัวนี้ คุณต้องการลบ NodeMCU หรือไม่',
                        goToMenu: 'ลบ',
                        cancelMenu: 'ยกเลิก',
                        goToOnPressed: () =>
                            _homeBloc.add(ConfirmDelete(state.nodeID)),
                        cancelOnPressed: () => Navigator.pop(context)),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadedHomeState) {
                  nodeMCUList = state.response;
                  sliverWidget = [
                    Column(
                      children: List.generate(
                        nodeMCUList.length,
                        (index) => CardNodeMcu(
                          nodeMCU: nodeMCUList,
                          index: index,
                          homeBloc: _homeBloc,
                        ),
                      ).toList(),
                    )
                  ];
                } else if (state is LoadDataAPIState || state is HomeInitial) {
                  _homeBloc.add(LoadDataAPI());
                } else if (state is LoadedNodeNull) {
                  sliverWidget = [
                    Container(
                      margin: MediaQuery.of(context).padding * 2,
                      child: EmptyDataWidget(
                        heading: 'ไม่พบข้อมูล NodeMCU',
                        content:
                            'กรุณาเพิ่มข้อมูล NodeMCU โดยการ\nกดไปที่ปุ่ม + มุมล่างขวา',
                      ),
                    ),
                  ];
                } else if (state is ErrorHomeState) {
                  sliverWidget = [
                    Container(
                      margin: MediaQuery.of(context).padding * 2,
                      child: ErrorWidgetState(
                        msg: '${state.errorMsg}',
                        onPressed: () {
                          _homeBloc.add(LoadDataAPI());
                        },
                      ),
                    ),
                  ];
                } else if (state is LoadingHomeState) {
                  sliverWidget = [
                    Container(
                      margin: MediaQuery.of(context).padding * 2,
                      child: Center(
                        child: RefreshProgressIndicator(),
                      ),
                    ),
                  ];
                }
                return SliverList(
                  delegate: SliverChildListDelegate(sliverWidget),
                );
              },
            ),
          ],
        ),
        AddWidget(
          tooltip: 'เพิ่ม NodeMCUESP8266',
          onPressed: () => _homeBloc.add(AddNodeMCU()),
        ),
      ],
    );
  }
}

class BodyHomeMobileLandscape extends StatelessWidget {
  final selected;
  BodyHomeMobileLandscape({Key key, @required this.selected}) : super(key: key);
  HomeBloc _homeBloc;
  List nodeMCUList = [];
  TextEditingController nodemcuProject = TextEditingController();
  TextEditingController nodemcuLocation = TextEditingController();
  String nodemcuStatus = 'Disconnect';

  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: AppDrawer(
            selected: selected,
          ),
        ),
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              BlocConsumer<HomeBloc, HomeState>(
                cubit: _homeBloc,
                listener: (context, state) {
                  if (state is AddNodeMCUState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormAddNodeMCU(
                                  homeBloc: _homeBloc,
                                )));
                  } else if (state is EditNodeMCUState) {
                    var _oldDataNodeMCU = state.oldDataState;
                    return Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormEditNodeMCU(
                                homeBloc: _homeBloc,
                                oldDataNodeMCU: _oldDataNodeMCU)));
                  } else if (state is AlertDeleteNodeMCUState) {
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) => AlertDialogStateWidget(
                          alertHeadline: 'ยืนยัน',
                          alertMsg:
                              'จะทำการลบอุปกรณ์หรือเซ็นเซอร์ทั้งหมดที่คุณเชื่อมกับ NodeMCU ตัวนี้ คุณต้องการลบ NodeMCU หรือไม่',
                          goToMenu: 'ลบ',
                          cancelMenu: 'ยกเลิก',
                          goToOnPressed: () =>
                              _homeBloc.add(ConfirmDelete(state.nodeID)),
                          cancelOnPressed: () => Navigator.pop(context)),
                    );
                  } else if (state is DeleteSucessfulState) {
                    return Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
                builder: (context, state) {
                  if (state is LoadedHomeState) {
                    nodeMCUList = state.response;
                  } else if (state is LoadDataAPIState ||
                      state is HomeInitial) {
                    _homeBloc.add(LoadDataAPI());
                  } else if (state is LoadedNodeNull) {
                    return EmptyDataWidget(
                      heading: 'ไม่พบข้อมูล NodeMCU',
                      content:
                          'กรุณาเพิ่มข้อมูล NodeMCU โดยการ\nกดไปที่ปุ่ม + มุมล่างขวา',
                    );
                  } else if (state is ErrorHomeState) {
                    return ErrorWidgetState(
                      msg: '${state.errorMsg}',
                      onPressed: () {
                        _homeBloc.add(LoadDataAPI());
                      },
                    );
                  } else if (state is LoadingHomeState) {
                    return Center(child: RefreshProgressIndicator());
                  }
                  return GridView.builder(
                      padding: EdgeInsets.only(top: 43),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              2.5 /
                              MediaQuery.of(context).size.height),
                      itemCount: nodeMCUList.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CardNodeMcu(
                              nodeMCU: nodeMCUList,
                              index: index,
                              homeBloc: _homeBloc,
                            ),
                          ));
                },
              ),
              AddWidget(
                tooltip: 'เพิ่ม NodeMCUESP8266',
                onPressed: () => _homeBloc.add(AddNodeMCU()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
