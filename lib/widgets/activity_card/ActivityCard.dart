import 'package:flutter/material.dart';

import '../../constants.dart';

class ActivityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('user-name', style: Theme.of(context).textTheme.body2),
              Text('czp #', style: Theme.of(context).textTheme.body2),
              Text('cabildo-name', style: Theme.of(context).textTheme.body2),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 162,
              decoration: BoxDecoration(
                color: CARD_BACKGROUND,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('# pings', style: Theme.of(context).textTheme.body2),
              Text('# comments', style: Theme.of(context).textTheme.body2),
              Text('date-time', style: Theme.of(context).textTheme.body2),
            ],
          ),
          Divider(
            color: CARD_DIVIDER,
            thickness: 3,
          ),
        ],
      ),
    );
  }
}
