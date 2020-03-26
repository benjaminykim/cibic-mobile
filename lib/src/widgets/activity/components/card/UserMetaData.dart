import 'package:flutter/material.dart';

import '../../../IconTag.dart';

class UserMetaData extends StatelessWidget {
  final String userName;
  final String cp;
  final String cabildoName;

  UserMetaData(this.userName, this.cp, this.cabildoName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
      child: Row(
        children: <Widget>[
          IconTag(Icon(Icons.person, size: 20), userName),
          Spacer(),
          IconTag(Icon(Icons.offline_bolt, size: 20), cp),
          Spacer(),
          IconTag(Icon(Icons.looks, size: 20), cabildoName),
        ],
      ),
    );
  }
}
