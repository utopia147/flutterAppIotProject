import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_relay/relay_bloc.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Relay/relay_screen.dart';

class FormAddRelay extends StatelessWidget {
  FormAddRelay({Key key, @required this.relayBloc, @required this.nodemcuData})
      : super(key: key);
  final RelayBloc relayBloc;
  final List<dynamic> nodemcuData;

  final _formKey = GlobalKey<FormState>();
  TextEditingController channelname = TextEditingController();
  int no = 0;
  String nodemcuid;

  bool status = false;
  bool channelStatus = true;
  @override
  Widget build(BuildContext context) {
    nodemcuid = nodemcuData[0]['_id'];
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => RelayScreen()),
                  (Route<dynamic> route) => false)),
          title: Text('เพิ่ม Relay'),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  child: Icon(
                    Icons.add_box,
                    size: 30,
                  ),
                  onTap: () {
                    print('tap');
                    if (_formKey.currentState.validate()) {
                      relayBloc.add(SendAddRelayData(
                          nodemcuid, channelname.text, status, channelStatus));
                    }
                  },
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<RelayBloc, RelayState>(
          cubit: relayBloc,
          listener: (context, state) {
            if (state is SendRelayDataSucessState) {
              return Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => RelayScreen()),
                  (Route<dynamic> route) => false);
            } else if (state is SendRelayDataFailedState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: Text("ลองดูอีกครั้ง"),
                      content: CupertinoActivityIndicator(
                        radius: 15,
                      ),
                    );
                  });
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  autovalidate: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.bubble_chart,
                                    color: Colors.pinkAccent,
                                  ),
                                  labelText: 'เลือก Project'),
                              value: nodemcuid,
                              icon: Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String newValue) {
                                print(newValue);
                                nodemcuid = newValue;
                              },
                              items: nodemcuData
                                  .map<DropdownMenuItem<String>>((data) {
                                no++;
                                return DropdownMenuItem<String>(
                                  value: data['_id'],
                                  child: Text(
                                    '${data['nodemcuProject']}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.black26),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: channelname,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'กรุณาใส่ชื่ออุปกรณ์';
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'อุปกรณ์',
                                  labelStyle: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  prefixIcon: Icon(
                                    Icons.build,
                                    color: Colors.pinkAccent,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class FormEditRelay extends StatelessWidget {
  FormEditRelay(
      {Key key,
      @required this.relayBloc,
      @required this.oldDataRelay,
      @required this.nodeMCU})
      : super(key: key);
  final RelayBloc relayBloc;
  final Map<String, dynamic> oldDataRelay;
  final List<dynamic> nodeMCU;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String editNodeID = oldDataRelay['nodemcuid'];
    String oldSelected = oldDataRelay['nodemcuid'];
    String editChannelID = oldDataRelay['_id'];
    int no = 0;
    TextEditingController editChannelname =
        TextEditingController(text: oldDataRelay['channelname']);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.orange),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => RelayScreen()),
                (Route<dynamic> route) => false)),
        title: Text('แก้ไข NodeMCU'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
                onPressed: () {
                  print('tap');
                  relayBloc.add(SendEditRelayData(
                      editChannelID, editNodeID, editChannelname.text));
                }),
          )
        ],
      ),
      body: BlocConsumer<RelayBloc, RelayState>(
        cubit: relayBloc,
        listener: (context, state) {
          if (state is SendRelayDataSucessState) {
            print('edit state');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => RelayScreen()),
                (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.black26),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.bubble_chart,
                                  color: Colors.orange,
                                ),
                                labelText: 'เลือก Project'),
                            value: oldSelected,
                            icon: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                              ),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.orange,
                              ),
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            onChanged: (String newValue) {
                              print(newValue);
                              editNodeID = newValue;
                            },
                            items:
                                nodeMCU.map<DropdownMenuItem<String>>((data) {
                              no++;
                              return DropdownMenuItem<String>(
                                value: data['_id'],
                                child: Text(
                                  '${data['nodemcuProject']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.black26),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: editChannelname,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'กรุณาใส่ชื่ออุปกรณ์';
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'อุปกรณ์',
                                labelStyle: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                                prefixIcon: Icon(
                                  Icons.build,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
