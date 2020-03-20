import 'package:flutter/material.dart';

class CardMetaData extends StatelessWidget {
  final int pingNum;
  final int commentNum;
  final String dateTime;

  CardMetaData(this.pingNum, this.commentNum, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:30),
            width: MediaQuery.of(context).size.width / 3 + 10,
            child: Text('$pingNum pings', style: Theme.of(context).textTheme.body2)),
          Spacer(),
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width / 3 - 10,
            child: Text('$commentNum commentarios',
                style: Theme.of(context).textTheme.body2),
          ),
          Spacer(),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right:30),
            width: MediaQuery.of(context).size.width / 3 - 20,
            // child: Text('hace $dateTime', style: Theme.of(context).textTheme.body2)),
            child: Text('hace 1 dia', style: Theme.of(context).textTheme.body2)),
        ],
      ),
    );
  }
}
