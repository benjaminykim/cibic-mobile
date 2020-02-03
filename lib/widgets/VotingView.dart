import 'package:flutter/material.dart';

class VotingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 28,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.arrow_upward),
            Text("12.2k",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                )),
            Icon(Icons.arrow_downward),
          ],
        ));
  }
}
