import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:flutter/material.dart';

String generateTimeString(DateTime publishDate) {
  DateTime now = DateTime.now();
  int diff = now.difference(publishDate).inDays.toInt();

  if (diff >= 365) {
    return "Hace " + (diff ~/ 365).toString() + " anos";
  } else if (diff >= 60) {
    return "Hace " + (diff ~/ 30).toString() + " meses";
  } else if (diff >= 30) {
    return "Hace un mes";
  } else if (diff >= 14) {
    return "Hace " + (diff ~/ 7).toString() + " semanas";
  } else if (diff >= 7) {
    return "Hace una semana";
  } else if (diff >= 2) {
    return "Hace " + (diff).toString() + " dias";
  } else if (diff == 1) {
    return "Hace una día";
  }

  diff = now.difference(publishDate).inMinutes.toInt();
  if (diff >= 120) {
    return "Hace " + (diff ~/ 60).toString() + " horas";
  } else if (diff >= 60) {
    return "Hace una hora";
  } else if (diff >= 2) {
    return "Hace " + (diff).toString() + " minutos";
  } else {
    return "Hace un minuto";
  }
}

class CardMetaData extends StatelessWidget {
  final int pingNum;
  final int commentNum;
  final DateTime publishDate;

  factory CardMetaData.fromActivity(ActivityModel activity) {
    return CardMetaData(
      activity.ping,
      activity.commentNumber,
      activity.publishDate);
  }

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
            child: Text('$pingNum Pings', style: Theme.of(context).textTheme.bodyText2)),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text('$commentNum Comentarios', style: Theme.of(context).textTheme.bodyText2)),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 30,
            child: Text(generateTimeString(this.publishDate), style: Theme.of(context).textTheme.bodyText2)),
        ],
      ),
    );
  }
}
