import 'package:flutter/material.dart';

class AlertDialogStateWidget extends StatelessWidget {
  const AlertDialogStateWidget({
    Key key,
    @required String alertHeadline,
    @required String alertMsg,
    @required String goToMenu,
    @required String cancelMenu,
    @required VoidCallback goToOnPressed,
    @required VoidCallback cancelOnPressed,
  })  : _alertHeadline = alertHeadline,
        _alertMsg = alertMsg,
        _goToMenu = goToMenu,
        _goToOnPressed = goToOnPressed,
        _cancelMenu = cancelMenu,
        _cancelOnPressed = cancelOnPressed,
        super(key: key);

  final String _alertHeadline;
  final String _alertMsg;
  final String _goToMenu;
  final String _cancelMenu;
  final VoidCallback _goToOnPressed;
  final VoidCallback _cancelOnPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$_alertHeadline',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        '$_alertMsg',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        FlatButton(
          child: new Text(
            "$_goToMenu",
          ),
          onPressed: _goToOnPressed,
        ),
        FlatButton(
          child: Text(
            "$_cancelMenu",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: _cancelOnPressed,
        ),
      ],
    );
  }
}
