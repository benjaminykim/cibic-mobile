import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityCard.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux/redux.dart';

Future<UserModel> fetchUserFeed(String idUser) async {
  final response = await http.get(API_BASE + ENDPOINT_USER_FEED + idUser);

  if (response.statusCode == 200) {
    return UserModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(
        'Failed to load home feed: ' + response.statusCode.toString());
  }
}

class SelfProfileScreen extends StatefulWidget {
  final String idUser;

  SelfProfileScreen(this.idUser);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<SelfProfileScreen> {
  Future<UserModel> user;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  String followButtonText = "seguir";
  Color followButtonColor = Colors.green;

  @override
  void initState() {
    super.initState();
    user = fetchUserFeed(widget.idUser);
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      user = fetchUserFeed(widget.idUser);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: Container(
            color: APP_BACKGROUND,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<UserModel>(
                      future: this.user,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // user profile picture, name
                                    Column(
                                      children: [
                                        // image
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
                                        // name
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 4, 5, 0),
                                          width: 120,
                                          child: Text(
                                            snapshot.data.username,
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
                                    // user meta data
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          160,
                                      margin:
                                          EdgeInsets.fromLTRB(10, 15, 15, 0),
                                      child: Column(
                                        children: [
                                          // citizen points, followers, cabildos following
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // citizen points
                                              Row(children: [
                                                Icon(Icons.offline_bolt),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(snapshot.data.citizenPoints.toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    )),
                                              ]),
                                              // followers
                                              Column(
                                                children: <Widget>[
                                                  Text(snapshot.data.followers.length.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  Text((snapshot.data.cabildos.length > 1) ? "seguidores" : "seguidor",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ))
                                                ],
                                              ),
                                              // cabildos
                                              Column(
                                                children: <Widget>[
                                                  Text(snapshot.data.cabildos.length.toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                      )),
                                                  Text((snapshot.data.cabildos.length > 1) ? "cabildos" : "cabildo",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                          // user introduction
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
                                                      'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsusectetelit. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dollore.',
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
                                // feed button bar
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200 - 70 - 14 - 59,
                    child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: () => refreshList(),
                      child: FutureBuilder<UserModel>(
                        future: user,
                        builder: (context, feedSnap) {
                          if (feedSnap.hasData) {
                            print("FeedSnap data: " + feedSnap.data.activityFeed.toString());
                            return ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.black,
                                    ),
                                itemCount: feedSnap.data.activityFeed.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ActivityModel activity =
                                      feedSnap.data.activityFeed[index];
                                  return ActivityCard(activity);
                                });
                          } else if (feedSnap.hasError) {
                            return ListView(children: [
                              Center(
                                child: Text("error: cibic servers are down",
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
    );
  }
}

class User {
  final String idUser;
  final String username;
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> activityFeed;
  final List<dynamic> cabildos;

  User(
      this.idUser,
      this.username,
      this.email,
      this.firstName,
      this.middleName,
      this.lastName,
      this.followers,
      this.following,
      this.activityFeed,
      this.cabildos);

  factory User.create(Store<AppState> store) {
    return User(
      store.state.idUser,
      store.state.username,
      store.state.email,
      store.state.firstName,
      store.state.middleName,
      store.state.lastName,
      store.state.followers,
      store.state.following,
      store.state.activityFeed,
      store.state.cabildos,
    );
  }
}
