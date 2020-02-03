import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardContents extends StatelessWidget {
  final String title;
  final String label;
  final String text;
  final int mode;
  final Map<String, Color> labelColorPicker = {
    'Proposal': LABEL_PROPOSAL_COLOR,
    'Discuss': LABEL_DISCUSS_COLOR,
    'Poll': LABEL_POLL_COLOR,
  };

  CardContents(this.title, this.label, this.text, this.mode);

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
                    label,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: labelColorPicker[label]),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            // Content
            ((label == "Poll")
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
