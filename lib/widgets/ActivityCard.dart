import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          // user metadata
          // card
          // card metadata
          Row(
            children: <Widget>[
              Text('user-name'),
              Text('czp: #'),
              Text('cabildo-name'),
            ],
          ),
          Container(),
          Row(
            children: <Widget>[
              Text('# pings'),
              Text('# comments'),
              Text('date-time'),
            ],
          ),
          Padding(
            child: Divider(
              color: Color(0xff2d9cdb),
              thickness: 3,
            ),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
        ],
      ),
    );
  }
}
