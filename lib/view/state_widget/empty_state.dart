import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    @required heading,
    @required content,
    Key key,
  })  : _heading = heading,
        _content = content,
        super(key: key);

  final String _heading;
  final String _content;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$_heading',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Raleway',
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Text(
                '$_content',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                child: Icon(Icons.add),
                backgroundColor: Colors.pinkAccent,
                radius: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
