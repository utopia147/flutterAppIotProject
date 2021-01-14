import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidgetState extends StatelessWidget {
  const ErrorWidgetState({
    Key key,
    @required String msg,
    @required VoidCallback onPressed,
  })  : errorMsg = msg,
        _onPressed = onPressed,
        super(key: key);

  final String errorMsg;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$errorMsg',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 120,
          child: RaisedButton(
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.refresh), Text('Refresh')],
            ),
            onPressed: _onPressed,
          ),
        )
      ],
    );
  }
}
