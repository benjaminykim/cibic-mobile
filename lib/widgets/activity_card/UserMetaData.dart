import 'package:flutter/material.dart';

import '../IconTag.dart';

class UserMetaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconTag(Icon(Icons.person), 'user-name'),
        IconTag(Icon(Icons.offline_bolt, size: 15), '1.1k'),
        IconTag(Icon(Icons.looks), 'cabildo-name'),
      ],
    );
  }
}
