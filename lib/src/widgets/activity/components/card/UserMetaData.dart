import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/profile/CabildoProfileScreen.dart';
import 'package:cibic_mobile/src/widgets/profile/UserProfileScreen.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/utils/IconTag.dart';

class UserMetaData extends StatelessWidget {
  final String jwt;
  final String userName;
  final String idUser;
  final String cabildoName;
  final String idCabildo;
  final int cp;
  final List<String> followers;

  UserMetaData(this.userName, this.cp, this.cabildoName, this.idUser,
      this.idCabildo, this.jwt, this.followers);

  factory UserMetaData.fromActivity(ActivityModel activity, String jwt) {
    print(activity.idUser.toString());
    return UserMetaData(
        activity.idUser['username'],
        activity.idUser['citizenPoints'],
        activity.idCabildo['name'],
        activity.idUser['_id'],
        activity.idCabildo['_id'],
        jwt,
        activity.idUser['following']);
  }

  void onUserTapped(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfileScreen(this.idUser, this.jwt)));
  }

  void onCabildoTapped(BuildContext context) {
    if (this.cabildoName == 'todo') {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CabildoProfileScreen(this.idCabildo, this.jwt)));
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
                child: IconTag(Icon(Icons.person, size: 20), userName)),
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
                child: IconTag(Icon(Icons.person, size: 20), userName)),
            Spacer(),
            IconTag(Icon(Icons.offline_bolt, size: 20), cp.toString()),
            Spacer(),
            GestureDetector(
                onTap: () => this.onCabildoTapped(context),
                child: IconTag(Icon(Icons.looks, size: 20), cabildoName)),
          ],
        ),
      );
    }
  }
}
