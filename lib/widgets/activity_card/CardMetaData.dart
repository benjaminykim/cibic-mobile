import 'package:flutter/material.dart';

class CardMetaData extends StatelessWidget {
  final String pingNum;
  final String commentNum;
  final String dateTime;

  CardMetaData(this.pingNum, this.commentNum, this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('$pingNum pings', style: Theme.of(context).textTheme.body2),
        Text('$commentNum comments', style: Theme.of(context).textTheme.body2),
        Text('$dateTime ago', style: Theme.of(context).textTheme.body2),
      ],
    );
  }
}
