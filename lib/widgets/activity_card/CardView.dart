import 'package:flutter/material.dart';

import '../../constants.dart';

class CardView extends StatelessWidget {
  final String title;
  final String label;
  final String text;

  CardView(this.title, this.label, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 162,
        decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(child: Icon(Icons.keyboard_arrow_left, size: 28)),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20 - 56,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Container(
                        width: 60,
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
                            border: Border.all(color: LABEL_PROPOSAL_COLOR),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Icon(Icons.keyboard_arrow_right, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
