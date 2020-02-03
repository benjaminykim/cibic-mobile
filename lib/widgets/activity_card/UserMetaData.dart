import 'package:flutter/material.dart';

class UserMetaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text('user-name', style: Theme.of(context).textTheme.body2),
        Text('czp #', style: Theme.of(context).textTheme.body2),
        Text('cabildo-name', style: Theme.of(context).textTheme.body2),
      ],
    );
  }
}
