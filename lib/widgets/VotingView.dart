import 'package:flutter/material.dart';

class VotingView extends StatelessWidget {
  final String score;

  VotingView(this.score);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 28,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.arrow_upward),
            Text(score,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                )),
            Icon(Icons.arrow_downward),
          ],
        ));
  }
}
