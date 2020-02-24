import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../IconTag.dart';

class CardContents extends StatelessWidget {
  final String title;
  final int type;
  final String text;
  final int mode;
  final Map<String, String> comments;


  CardContents(this.title, this.type, this.text, this.mode, this.comments);

  generateCardBody() {
    if (type == ACTIVITY_POLL && mode == CARD_DEFAULT) {
      //default poll card
      return (Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Icon(Icons.thumb_down, size: 50),
          ),
          Icon(Icons.thumb_up, size: 50)
        ],
      ));
    } else if (mode == CARD_COMMENT || mode == CARD_LAST) {
      // default comment card
      return (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTag(Icon(Icons.person, size: 15), comments['userName']),
              IconTag(Icon(Icons.offline_bolt, size: 15), comments['cp']),
            ],
          ),
          Text(
            comments['text'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Center(
            child: Text(
              comments['score'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          )
        ],
      ));
    } else {
      return (Text(
        // default discussion card
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20 - 56,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // title
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          // Content
          generateCardBody()
        ],
      ),
    );
  }
}
