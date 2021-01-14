import 'package:flutter/material.dart';

class AddWidget extends StatelessWidget {
  const AddWidget({
    Key key,
    @required tooltip,
    @required onPressed,
  })  : _tooltip = tooltip,
        _onPressed = onPressed,
        super(key: key);

  final String _tooltip;
  final VoidCallback _onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                // backgroundColor: Colors.pinkAccent,
                tooltip: _tooltip,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: _onPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
