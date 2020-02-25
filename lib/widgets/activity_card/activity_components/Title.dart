import 'package:flutter/material.dart';

import './Label.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final int type;

  CardTitle(this.title, this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(30, 12, 85, 0),
            child: Text(
              title,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Label(this.type),
        ],
      ),
    );
  }
}
