import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';

class CabildoCard extends StatelessWidget {
  final CabildoModel cabildo;

  CabildoCard(this.cabildo);

  @override
  Widget build(BuildContext context) {
    if (this.cabildo.members == null) {
      this.cabildo.members = [];
    }
    return Container(
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
                  cabildo.name,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // FOLLOWERS
              Column(
                children: <Widget>[
                  Text(cabildo.members.length.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                  Text((cabildo.members.length > 1) ? "seguidores" : "seguidor",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ))
                ],
              ),
              SizedBox(height: 20),
              // LOCATION
              Row(children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 5,
                ),
                Text(cabildo.location,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
