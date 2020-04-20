import 'package:flutter/material.dart';

String generateTimeString(DateTime publishDate) {
  DateTime now = DateTime.now();
  int diff = now.difference(publishDate).inDays.toInt();

  if (diff >= 365) {
    return "hace " + (diff ~/ 365).toString() + " anos";
  } else if (diff >= 60) {
    return "hace " + (diff ~/ 30).toString() + " meses";
  } else if (diff >= 30) {
    return "hace un mes";
  } else if (diff >= 14) {
    return "hace " + (diff ~/ 7).toString() + " semanas";
  } else if (diff >= 7) {
    return "hace una semana";
  } else if (diff >= 2) {
    return "hace " + (diff).toString() + " dias";
  } else if (diff == 1) {
    return "hace una dia";
  }

  diff = now.difference(publishDate).inMinutes.toInt();
  if (diff >= 120) {
    return "hace " + (diff ~/ 60).toString() + " horas";
  } else if (diff >= 60) {
    return "hace una hora";
  } else if (diff >= 2) {
    return "hace " + (diff).toString() + " minutos";
  } else {
    return "hace un minuto";
  }
}

class CardMetaData extends StatelessWidget {
  final int pingNum;
  final int commentNum;
  final DateTime publishDate;

  CardMetaData(this.pingNum, this.commentNum, this.publishDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text('$pingNum pings', style: Theme.of(context).textTheme.body2)),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text('$commentNum commentarios', style: Theme.of(context).textTheme.body2)),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text(generateTimeString(this.publishDate), style: Theme.of(context).textTheme.body2)),
        ],
      ),
    );
  }
}
