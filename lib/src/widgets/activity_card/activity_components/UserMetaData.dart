import 'package:flutter/material.dart';

import '../../IconTag.dart';

class UserMetaData extends StatelessWidget {
  final String userName;
  final String cp;
  final String cabildoName;

  UserMetaData(this.userName, this.cp, this.cabildoName);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 30),
            width: MediaQuery.of(context).size.width / 3 + 10,
            child: IconTag(Icon(Icons.person, size: 20), userName),
          ),
          Spacer(),
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width / 3 - 70,
            child: IconTag(Icon(Icons.offline_bolt, size: 20), cp),
          ),
          Spacer(),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 10),
            width: MediaQuery.of(context).size.width / 3 - 20,
            child: IconTag(Icon(Icons.looks, size: 20), cabildoName),
          ),
        ],
      ),
    );
  }
}
