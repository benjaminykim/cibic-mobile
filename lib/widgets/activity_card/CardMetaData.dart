import 'package:flutter/material.dart';

class CardMetaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('22.1k pings', style: Theme.of(context).textTheme.body2),
        Text('1.1k comments', style: Theme.of(context).textTheme.body2),
        Text('5 hours ago', style: Theme.of(context).textTheme.body2),
      ],
    );
  }
}
