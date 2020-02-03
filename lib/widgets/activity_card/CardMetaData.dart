import 'package:flutter/material.dart';

class CardMetaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('# pings', style: Theme.of(context).textTheme.body2),
        Text('# comments', style: Theme.of(context).textTheme.body2),
        Text('date-time', style: Theme.of(context).textTheme.body2),
      ],
    );
  }
}
