import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';

class CabildoProfileScreen extends StatefulWidget {
  final String idCabildo;
  final String jwt;

  CabildoProfileScreen(this.idCabildo, this.jwt);

  @override
  _CabildoProfileState createState() => _CabildoProfileState();
}

class _CabildoProfileState extends State<CabildoProfileScreen> {
  Future<CabildoModel> cabildo;
  Future<FeedModel> feed;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  String followButtonText = "seguir";
  Color followButtonColor = Colors.green;
  bool isFollowing = false;
  String idRootUser;

  @override
  void initState() {
    super.initState();
    cabildo = fetchCabildoProfile(widget.idCabildo, widget.jwt);
    feed = fetchCabildoFeed(widget.idCabildo, widget.jwt);
    this.idRootUser = extractID(widget.jwt);
  }

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cabildo = fetchCabildoProfile(widget.idCabildo, widget.jwt);
      feed = fetchCabildoFeed(widget.idCabildo, widget.jwt);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<CabildoModel>(
              future: this.cabildo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ));
                } else if (snapshot.hasError) {
                  return Text("error");
                }
                return Text("name not found");
              }),
          centerTitle: true,
          titleSpacing: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Center(
          child: Container(
            color: APP_BACKGROUND,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // PROFILE INFO WIDGET
                  FutureBuilder<CabildoModel>(
                      future: this.cabildo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Column(
                              children: [
                                // IMAGE, NAME, FOLLOW BUTTON, CABILDO METADATA
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // IMAGE, NAME, FOLLOW BUTTON
                                    Column(
                                      children: [
                                        // IMAGE
                                        Container(
                                          width: 85.0,
                                          height: 85.0,
                                          margin: EdgeInsets.fromLTRB(
                                              15, 15, 15, 0),
                                          decoration: new BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        // NAME
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 4, 5, 0),
                                          width: 120,
                                          child: Text(
                                            snapshot.data.name,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        // FOLLOW BUTTON
                                        Container(
                                            height: 17,
                                            child: FlatButton(
                                              color: (this.isFollowing ||
                                                      snapshot.data.members.any(
                                                          (k) =>
                                                              k['_id'] ==
                                                              idRootUser))
                                                  ? Colors.blue
                                                  : Colors.green,
                                              onPressed: () async {
                                                if (this.followButtonText ==
                                                    "seguir") {
                                                  String ret = await followCabildo(
                                                      widget.idCabildo,
                                                      widget.jwt);
                                                  if (ret != "error") {
                                                    setState(() {
                                                      this.isFollowing = true;
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    this.isFollowing = false;
                                                  });
                                                }
                                              },
                                              child: Text(
                                                  (this.isFollowing ||
                                                          snapshot.data.members
                                                              .any((k) =>
                                                                  k['_id'] ==
                                                                  idRootUser))
                                                      ? "siguiendo"
                                                      : "seguir",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  )),
                                            )),
                                      ],
                                    ),
                                    // CABILDO METADATA
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          160,
                                      margin:
                                          EdgeInsets.fromLTRB(10, 15, 15, 0),
                                      child: Column(
                                        children: [
                                          // FOLLOWERS AND LOCATION
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // FOLLOWERS
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                      snapshot
                                                          .data.members.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  Text(
                                                      (snapshot.data.members
                                                                  .length >
                                                              1)
                                                          ? "seguidores"
                                                          : "seguidor",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              // LOCATION
                                              Row(children: [
                                                Icon(Icons.location_on),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(snapshot.data.location,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    )),
                                              ]),
                                            ],
                                          ),
                                          // CABILDO INTRODUCTION
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            alignment: Alignment.topLeft,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  this.maxLines = 100;
                                                });
                                              },
                                              child: Container(
                                                height: 76,
                                                child: ListView(
                                                  children: [
                                                    Text(
                                                      snapshot.data.desc,
                                                      maxLines: this.maxLines,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // FEED BUTTON BAR
                                Container(
                                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Actividad",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "Encuestas",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "Discusiones",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("error");
                        }
                        return Text("username not found");
                      }),
                  // feed
                  Expanded(
                    child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: () => refreshList(),
                      child: FutureBuilder<FeedModel>(
                        future: this.feed,
                        builder: (context, feedSnap) {
                          if (feedSnap.hasData) {
                            return ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.black,
                                    ),
                                itemCount: feedSnap.data.feed.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return (ActivityView(
                                      feedSnap.data.feed[index], widget.jwt));
                                });
                          } else if (feedSnap.hasError) {
                            return ListView(children: [
                              Center(
                                child: Text("error: Cibic servers are down",
                                    style: TextStyle(color: Colors.black)),
                              )
                            ]);
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
