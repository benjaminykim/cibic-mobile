import 'package:flutter/material.dart';

import '../IconTag.dart';

class UserMetaData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconTag(Icon(Icons.person, size: 20), 'user-name'),
        IconTag(Icon(Icons.offline_bolt, size: 20), '1.1k'),
        IconTag(Icon(Icons.looks, size: 20), 'cabildo-name'),
      ],
    );
  }
}
