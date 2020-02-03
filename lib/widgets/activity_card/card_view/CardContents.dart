import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardContents extends StatelessWidget {
  final String title;
  final int type;
  final String text;
  final int mode;
  final Map<int, Color> labelColorPicker = {
    ACTIVITY_PROPOSAL: LABEL_PROPOSAL_COLOR,
    ACTIVITY_DISCUSS: LABEL_DISCUSS_COLOR,
    ACTIVITY_POLL: LABEL_POLL_COLOR,
  };
  final Map<int, String> labelTextPicker = {
    ACTIVITY_PROPOSAL: 'Proposal',
    ACTIVITY_DISCUSS: 'Discuss',
    ACTIVITY_POLL: 'Poll',
  };

  CardContents(this.title, this.type, this.text, this.mode);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20 - 56,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // title
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 17, 0, 5),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Label
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                width: 80,
                child: Center(
                  child: Text(
                    labelTextPicker[type],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: labelColorPicker[type]),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            // Content
            ((type == ACTIVITY_POLL)
                ? (Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Icon(Icons.thumb_down, size: 50),
                      ),
                      Icon(Icons.thumb_up, size: 50)
                    ],
                  ))
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
