import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';

class FormAddNodeMCU extends StatelessWidget {
  FormAddNodeMCU({Key key, @required this.homeBloc}) : super(key: key);
  final HomeBloc homeBloc;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nodemcuProject = TextEditingController();
  TextEditingController nodemcuLocation = TextEditingController();
  String nodemcuStatus = 'Disconnect';
  @override
  Widget build(BuildContext context) {
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
                      builder: (BuildContext context) => HomeScreen()),
                  (Route<dynamic> route) => false)),
          title: Text('เพิ่มอุปกรณ์'),
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
                      homeBloc.add(SendAddNodeMCU(nodemcuProject.text,
                          nodemcuLocation.text, nodemcuStatus));
                    }
                  },
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          cubit: homeBloc,
          listener: (context, state) {
            if (state is AddSucessfulState) {
              return Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()),
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
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: nodemcuProject,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'กรุณาใส่ชื่อ Project';
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Project',
                                  labelStyle: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  prefixIcon: Icon(
                                    Icons.flare,
                                    color: Colors.pinkAccent,
                                    size: 20,
                                  ),
                                ),
                              ),
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
                                controller: nodemcuLocation,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'กรุณาใส่ชื่อสถานที่ที่ติดตั้ง';
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Location',
                                  labelStyle: TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  prefixIcon: Icon(
                                    Icons.location_on,
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

class FormEditNodeMCU extends StatelessWidget {
  FormEditNodeMCU({
    Key key,
    @required this.homeBloc,
    @required this.oldDataNodeMCU,
  }) : super(key: key);
  final HomeBloc homeBloc;
  final Map<String, dynamic> oldDataNodeMCU;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String nodeID = oldDataNodeMCU['_id'];
    TextEditingController _editNodemcuProject =
        TextEditingController(text: oldDataNodeMCU['nodemcuProject']);
    TextEditingController _editNodemcuLocation =
        TextEditingController(text: oldDataNodeMCU['nodemcuLocation']);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.orange),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()),
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
                  homeBloc.add(SendEditNodeMCUApi(nodeID,
                      _editNodemcuProject.text, _editNodemcuLocation.text));
                }),
          )
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        cubit: homeBloc,
        listener: (context, state) {
          if (state is EditSucessfulState) {
            print('edit state');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()),
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
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.5, color: Colors.black26),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _editNodemcuProject,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'กรุณาใส่ชื่อ Project';
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Project',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                              prefixIcon: Icon(
                                Icons.flare,
                                color: Colors.orange,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _editNodemcuLocation,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'กรุณาใส่ชื่อสถานที่ที่ติดตั้ง';
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Location',
                              labelStyle: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                              prefixIcon: Icon(
                                Icons.location_on,
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
          ));
        },
      ),
    );
  }
}
