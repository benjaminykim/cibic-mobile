import 'package:flutter/material.dart';

import '../../IconTag.dart';

class UserMetaData extends StatelessWidget {
  final String userName;
  final String cp;
  final String cabildoName;

  UserMetaData(this.userName, this.cp, this.cabildoName);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:20),
            width: MediaQuery.of(context).size.width / 2 - 30,
            child: IconTag(Icon(Icons.person, size: 20), userName),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 40,
            child: IconTag(Icon(Icons.offline_bolt, size: 20), cp),
          ),
          IconTag(Icon(Icons.looks, size: 20), cabildoName),
        ],
      ),
    );
  }
}
