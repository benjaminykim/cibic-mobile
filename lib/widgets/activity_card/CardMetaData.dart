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
        Text('${pingNum}k pings', style: Theme.of(context).textTheme.body2),
        Text('${commentNum}k comments', style: Theme.of(context).textTheme.body2),
        Text(dateTime, style: Theme.of(context).textTheme.body2),
      ],
    );
  }
}
