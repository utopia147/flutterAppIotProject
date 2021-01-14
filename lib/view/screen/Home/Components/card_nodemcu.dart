import 'package:flutter/material.dart';
import 'package:projectcontrol_app/Consitants.dart';
import 'package:projectcontrol_app/bloc/bloc_home/home_bloc.dart';

class CardNodeMcu extends StatelessWidget {
  const CardNodeMcu({
    Key key,
    @required this.nodeMCU,
    @required this.index,
    @required this.homeBloc,
  }) : super(key: key);

  final List nodeMCU;
  final int index;
  final HomeBloc homeBloc;

  void _choicesAction(String choice) {
    if (choice == 'Edit') {
      homeBloc.add(EditNodeMCU(nodeMCU[index]));
    } else if (choice == 'Delete') {
      String nodeID = nodeMCU[index]['_id'];
      // print(index);
      // print(nodeID);
      homeBloc.add(DeleteNodeMCU(nodeID));
    }
    print(choice);
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var colorConnection;
    var imgNode;
    var iconNode;
    switch (nodeMCU[index]['nodemcuStatus']) {
      case 'Conected':
        colorConnection = Colors.greenAccent[700];
        imgNode = Image.asset(
          'images/nodemcu.gif',
        );
        iconNode = Icons.flash_on;
        break;
      case 'Timeout':
        colorConnection = Colors.yellow[600];
        imgNode = Image.asset(
          'images/nodemcutimeout.gif',
        );
        iconNode = Icons.access_time;
        break;
      case 'Disconnect':
        colorConnection = Colors.red;
        imgNode = Image.asset(
          'images/nodemcudis.gif',
        );
        iconNode = Icons.flash_off;
        break;
    }

    return Card(
      elevation: 0,
      color: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: ListTile(
              trailing: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: (orientation == Orientation.portrait) ? 30 : 25,
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
              leading: Icon(
                iconNode,
                color: colorConnection,
                size: (orientation == Orientation.portrait) ? 20 : 16,
              ),
              title: Text(
                'NodeMCUESP8266 ตัวที่  ${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (orientation == Orientation.portrait) ? 14 : 12,
                ),
              ),
              subtitle: Text(
                nodeMCU[index]['nodemcuStatus'],
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: (orientation == Orientation.portrait) ? 14 : 12),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(color: Colors.white.withAlpha(155), width: 0.9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: imgNode,
          ),
          Text(
            'Project: ${nodeMCU[index]['nodemcuProject']}.',
            style: TextStyle(
                fontSize: (orientation == Orientation.portrait) ? 20 : 14,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
          Text(
            'Location: ${nodeMCU[index]['nodemcuLocation']}.',
            style: TextStyle(
                fontSize: (orientation == Orientation.portrait) ? 16 : 12,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                  text: 'NodeMCUESP8266',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: (orientation == Orientation.portrait) ? 14 : 12,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${nodeMCU[index]['nodemcuStatus']}.',
                      style: TextStyle(
                        color: colorConnection,
                        fontSize:
                            (orientation == Orientation.portrait) ? 16 : 12,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: '\n Datetime: ' + nodeMCU[index]['dateConnection'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize:
                            (orientation == Orientation.portrait) ? 16 : 12,
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
