import 'package:flutter/material.dart';

class CardMetaData extends StatelessWidget {
  final int pingNum;
  final int commentNum;
  final String dateTime;

  CardMetaData(this.pingNum, this.commentNum, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text('$pingNum pings', style: Theme.of(context).textTheme.body2)),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text('$commentNum commentarios', style: Theme.of(context).textTheme.body2)),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            // child: Text('hace $dateTime', style: Theme.of(context).textTheme.body2)),
            child: Text('hace 1 dia', style: Theme.of(context).textTheme.body2)),
        ],
      ),
    );
  }
}
