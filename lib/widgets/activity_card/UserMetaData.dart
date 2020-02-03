import 'package:flutter/material.dart';

import '../IconTag.dart';

class UserMetaData extends StatelessWidget {
  final String userName;
  final String cp;
  final String cabildoName;

  UserMetaData(this.userName, this.cp, this.cabildoName);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconTag(Icon(Icons.person, size: 20), userName),
        IconTag(Icon(Icons.offline_bolt, size: 20), cp),
        IconTag(Icon(Icons.looks, size: 20), cabildoName),
      ],
    );
  }
}
