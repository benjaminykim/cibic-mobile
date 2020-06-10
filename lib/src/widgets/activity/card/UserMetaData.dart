import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/card/IconTag.dart';
import 'package:cibic_mobile/src/widgets/profile/CabildoProfileScreen.dart';
import 'package:cibic_mobile/src/widgets/profile/UserProfileScreen.dart';
import 'package:flutter/material.dart';


class UserMetaData extends StatelessWidget {
  final String firstName;
  final int idUser;
  final String cabildoName;
  final int idCabildo;
  final int cp;
  final List<String> followers;

  UserMetaData(this.firstName, this.cp, this.cabildoName, this.idUser,
      this.idCabildo, this.followers);

  factory UserMetaData.fromActivity(ActivityModel activity) {
    if (activity.cabildo == null) {
      activity.cabildo = {'name': 'todo', 'id': -1};
    }
    return UserMetaData(
        activity.user['firstName'],
        activity.user['citizenPoints'],
        activity.cabildo['name'],
        activity.user['id'],
        activity.cabildo['id'],
        activity.user['following']);
  }

  void onUserTapped(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfileScreen(this.idUser)));
  }

  void onCabildoTapped(BuildContext context) {
    if (this.cabildoName == 'todo') {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CabildoProfileScreen(this.idCabildo)));
  }

  @override
  Widget build(BuildContext context) {
    if (this.cabildoName == null) {
      return Container(
        height: 20,
        child: Row(
          children: <Widget>[
            GestureDetector(
                onTap: () => this.onUserTapped(context),
                child: IconTag(Icon(Icons.person, size: 20), firstName)),
            Spacer(),
            IconTag(Icon(Icons.offline_bolt, size: 20), cp.toString()),
          ],
        ),
      );
    } else {
      return Container(
        height: 20,
        margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: Row(
          children: <Widget>[
            GestureDetector(
                onTap: () => this.onUserTapped(context),
                child: IconTag(Icon(Icons.person, size: 20), firstName)),
            Spacer(),
            //IconTag(Icon(Icons.offline_bolt, size: 20), cp.toString()),
            //Spacer(),
            GestureDetector(
                onTap: () => this.onCabildoTapped(context),
                child: IconTag(Icon(Icons.looks, size: 20), cabildoName)),
          ],
        ),
      );
    }
  }
}
