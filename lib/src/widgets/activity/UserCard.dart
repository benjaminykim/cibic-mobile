import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/profile/UserProfileScreen.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  UserCard(this.user);

  void onUserTapped(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfileScreen(this.user.id)));
  }

  @override
  Widget build(BuildContext context) {
    if (user.followers == null) {
      user.followers = [];
    }
    if (user.cabildos == null) {
      user.cabildos = [];
    }
    return GestureDetector(
      onTap: () => this.onUserTapped(context),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
            color: CARD_BACKGROUND,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  spreadRadius: 0,
                  offset: Offset(3.0, 3.0))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // IMAGE
                Container(
                  width: 85.0,
                  height: 85.0,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                // NAME
                Container(
                  margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
                  width: 120,
                  child: Text(
                    "${user.firstName} ${user.lastName}",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // citizen points
                  Row(children: [
                    Icon(Icons.offline_bolt),
                    SizedBox(
                      width: 5,
                    ),
                    Text(user.citizenPoints.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                  ]),
                  SizedBox(height: 10),
                  // followers
                  Column(
                    children: <Widget>[
                      Text(user.followers.length.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                          (user.followers.length > 1 ||
                                  user.followers.length == 0)
                              ? "seguidores"
                              : "seguidor",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  // cabildos
                  Column(
                    children: <Widget>[
                      Text(user.cabildos.length.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      Text(
                          (user.cabildos.length > 1 ||
                                  user.cabildos.length == 0)
                              ? "cabildos"
                              : "cabildo",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
