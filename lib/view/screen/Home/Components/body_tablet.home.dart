import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';

import 'package:projectcontrol_app/view/screen/Home/Components/card_nodemcu.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/state_widget/add_widget.dart';
import 'package:projectcontrol_app/view/state_widget/alert_state.dart';
import 'package:projectcontrol_app/view/state_widget/empty_state.dart';
import 'package:projectcontrol_app/view/state_widget/error_state.dart';
import 'package:projectcontrol_app/view/widget/intro/widget_intro_mobile.dart';

class BodyHome extends StatelessWidget {
  HomeBloc _homeBloc;
  List nodeMCUList = [];
  TextEditingController nodemcuProject = TextEditingController();
  TextEditingController nodemcuLocation = TextEditingController();
  String nodemcuStatus = 'Disconnect';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    Widget _logoHome() {
      return Container(
        height: 220,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _logoHome(),
            Flexible(
              child: BlocConsumer<HomeBloc, HomeState>(
                cubit: _homeBloc,
                listener: (context, state) {
                  if (state is AddSucessfulState ||
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
                  } else if (state is AddNodeMCUState) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: InkWell(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.pinkAccent,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      _homeBloc.add(LoadDataAPI());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Form(
                                    key: _formKey,
                                    autovalidate: true,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: nodemcuProject,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'กรุณาใส่ชื่อ Project';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Project',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                              prefixIcon: Icon(
                                                Icons.flare,
                                                color: Colors.pinkAccent,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: nodemcuLocation,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'กรุณาใส่ชื่อสถานที่ที่ติดตั้ง';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Location',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                              prefixIcon: Icon(
                                                Icons.location_on,
                                                color: Colors.pinkAccent,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            color: Colors.pinkAccent,
                                            child: Text(
                                              "เพิ่ม",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _homeBloc.add(SendAddNodeMCU(
                                                    nodemcuProject.text,
                                                    nodemcuLocation.text,
                                                    nodemcuStatus));
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is EditNodeMCUState) {
                    String nodeID = state.oldDataState['_id'];
                    TextEditingController _editNodemcuProject =
                        TextEditingController(
                            text: state.oldDataState['nodemcuProject']);
                    TextEditingController _editNodemcuLocation =
                        TextEditingController(
                            text: state.oldDataState['nodemcuLocation']);
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: InkWell(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      // _homeBloc.add(LoadDataAPI());
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _editNodemcuProject,
                                            decoration: InputDecoration(
                                              labelText: 'แก้ไข Project',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                              prefixIcon: Icon(
                                                Icons.flare,
                                                color: Colors.orange,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _editNodemcuLocation,
                                            decoration: InputDecoration(
                                              labelText: 'แก้ไข Location',
                                              labelStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                              prefixIcon: Icon(
                                                Icons.location_on,
                                                color: Colors.orange,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            color: Colors.orange,
                                            child: Text(
                                              "ยืนยันการแก้ไข",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              // _homeBloc
                                              //     .add(SendEditNodeMCUApiState(
                                              //   nodeID,
                                              //   _editNodemcuProject.text,
                                              //   _editNodemcuLocation.text,
                                              // ));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is LoadingHomeState) {
                    return Center(child: RefreshProgressIndicator());
                  }
                  return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: MediaQuery.of(context).size.height /
                              2.5 /
                              MediaQuery.of(context).size.width),
                      itemCount: nodeMCUList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CardNodeMcu(
                            nodeMCU: nodeMCUList,
                            index: index,
                            homeBloc: _homeBloc,
                          ));
                },
              ),
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
