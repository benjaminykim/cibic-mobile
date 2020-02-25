import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../IconTag.dart';

class CardContents extends StatefulWidget {
  final String title;
  final int type;
  final String text;
  final int mode;
  final Map<String, String> comments;

  CardContents(this.title, this.type, this.text, this.mode, this.comments);

  @override
  _CardContentsState createState() => _CardContentsState();
}

class _CardContentsState extends State<CardContents> {
  double reactValue = 2.0;

  Color reactColor()
  {
    switch(reactValue)
    {
      case 0:
        return Color(0xffe43535);
      case 1:
        return Color(0xffea8414);
      case 2:
        return Color(0xfff2e131);
      case 3:
        return Color(0xff80d25c);
      case 4:
        return Color(0xff22ba8e);
    }

  }

  generateCardBody() {
    if (widget.type == ACTIVITY_POLL && widget.mode == CARD_DEFAULT) {
      //default poll card
      return (Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Icon(Icons.thumb_down, size: 50),
          ),
          Icon(Icons.thumb_up, size: 50)
        ],
      ));
    } else if (widget.mode == CARD_COMMENT || widget.mode == CARD_LAST) {
      // default comment card
      return (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconTag(
                  Icon(Icons.person, size: 15), widget.comments['userName']),
              IconTag(
                  Icon(Icons.offline_bolt, size: 15), widget.comments['cp']),
            ],
          ),
          Text(
            widget.comments['text'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Center(
            child: Text(
              widget.comments['score'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          )
        ],
      ));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            // default discussion card
            widget.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            height: 40,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
                trackHeight: 5.0,
                thumbColor: reactColor(),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                //overlayColor: Colors.purple.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
              ),
              child: Slider(
                value: reactValue,
                onChanged: (value) => setState(() {
                  reactValue = value;
                }),
                max: 4.0,
                min: 0.0,
                divisions: 4,
              ),
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20 - 56,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[generateCardBody()],
      ),
    );
  }
}
