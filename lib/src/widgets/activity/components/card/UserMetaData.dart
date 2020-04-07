import 'package:cibic_mobile/src/widgets/profile/CabildoProfileScreen.dart';
import 'package:cibic_mobile/src/widgets/profile/UserProfileScreen.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/utils/IconTag.dart';

class UserMetaData extends StatelessWidget {
  final String userName;
  final String cabildoName;
  final String idUser;
  final String idCabildo;
  final int cp;
  final String jwt;

  UserMetaData(this.userName, this.cp, this.cabildoName, this.idUser, this.idCabildo, this.jwt);

  void onUserTapped(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserProfileScreen(this.idUser, this.jwt)));
  }

  void onCabildoTapped(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CabildoProfileScreen(this.idCabildo, this.jwt)));
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
