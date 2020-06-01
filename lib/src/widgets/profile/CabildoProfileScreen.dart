import 'dart:convert';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class CabildoProfileScreen extends StatefulWidget {
  final int idCabildo;

  CabildoProfileScreen(this.idCabildo);

  @override
  _CabildoProfileState createState() => _CabildoProfileState();
}

class _CabildoProfileState extends State<CabildoProfileScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  String followButtonText = "seguir";
  Color followButtonColor = Colors.green;
  bool isLoaded;
  bool isError;
  Future<CabildoModel> cabildoProfile;
  Future<FeedModel> cabildoFeed;

  @override
  initState() {
    super.initState();
    this.isLoaded = false;
    this.isError = false;
  }

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  Future<CabildoModel> fetchCabildoProfile(String id, String jwt) async {
    String url = API_BASE + ENDPOINT_CABILDO_PROFILE + id;

    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $jwt"
    });

    print("fetchProfile: ${response.statusCode}");
    if (response.statusCode == 200) {
      return CabildoModel.fromJson(json.decode(response.body));
    } else {
      setState(() {
        this.isError = true;
      });
    }
  }

  Future<FeedModel> fetchCabildoFeed(String id, String jwt) async {
    String url = API_BASE + ENDPOINT_CABILDO_FEED + id;

    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $jwt"
    });

    print("fetchFeed: ${response.statusCode}");
    if (response.statusCode == 200) {
      return FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    } else {
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CabildoViewModel>(
      converter: (Store<AppState> store) {
        Function onReact = (ActivityModel activity, int reactValue) =>
            store.dispatch(PostReactionAttempt(activity, reactValue, 3));
        Function onSave = (int activityId) =>
            store.dispatch(PostSaveAttempt(activityId, true));
        Function onCabildoFollow =
            () => {store.dispatch(PostCabildoFollowAttempt(widget.idCabildo))};
        Function onCabildoUnfollow = () =>
            {store.dispatch(PostCabildoUnfollowAttempt(widget.idCabildo))};
        return _CabildoViewModel(store.state.user['jwt'], onReact, onSave,
            onCabildoFollow, onCabildoUnfollow);
      },
      builder: (BuildContext context, _CabildoViewModel vm) {
        return MaterialApp(
          theme: cibicTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text("CABILDO",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
              centerTitle: true,
              titleSpacing: 0.0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Container(
              color: APP_BACKGROUND,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // PROFILE INFO WIDGET
                    FutureBuilder<CabildoModel>(
                      future: cabildoProfile,
                      builder: (context, snapshot) {
                        CabildoModel cabildo = snapshot.data;
                        return Container(
                          height: 204,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.5),
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
                                        margin:
                                            EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                      // FOLLOW BUTTON
                                      Container(
                                          height: 17,
                                          child: FlatButton(
                                            color: (cabildo.members.any(
                                                    (k) => k.id == vm.userId))
                                                ? Colors.blue
                                                : Colors.green,
                                            onPressed: () async {
                                              if (this.followButtonText ==
                                                  "seguir") {
                                                String ret = "";
                                                vm.onCabildoFollow(
                                                    widget.idCabildo);
                                                if (ret != "error") {
                                                  setState(() {
                                                    this.followButtonText =
                                                        "siguiendo";
                                                  });
                                                }
                                              } else {
                                                String ret = "";
                                                vm.onCabildoUnfollow(
                                                    widget.idCabildo);
                                                if (ret != "error") {
                                                  setState(() {
                                                    this.followButtonText =
                                                        "seguir";
                                                  });
                                                }
                                              }
                                            },
                                            child: Text(this.followButtonText,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                )),
                                          )),
                                    ],
                                  ),
                                  // CABILDO METADATA
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 160,
                                    margin: EdgeInsets.fromLTRB(10, 15, 15, 0),
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
                                                    cabildo.members.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                Text(
                                                    (cabildo.members.length > 1)
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
                                              Text(cabildo.location,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
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
                                                    cabildo.desc,
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
                            ],
                          ),
                        );
                      },
                    ),
                    // feed
                    FutureBuilder<FeedModel>(
                        future: cabildoFeed,
                        builder: (context, snapshot) {
                          return Expanded(
                            child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.black,
                                    ),
                                itemCount: snapshot.data.feed.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return (ActivityView(
                                      snapshot.data.feed[index],
                                      vm.onReact,
                                      vm.onSave,
                                      FEED_CABILDO));
                                }),
                          );
                        })
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class _CabildoViewModel {
  String jwt;
  int userId;
  Function onReact;
  Function onSave;
  Function onCabildoFollow;
  Function onCabildoUnfollow;
  _CabildoViewModel(this.jwt, this.onReact, this.onSave, this.onCabildoFollow,
      this.onCabildoUnfollow) {
        userId = extractID(jwt);
      }
}

// FEED BUTTON BAR
// Container(
//   margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//   height: 40,
//   decoration: BoxDecoration(
//     color: Colors.white,
//     border:
//         Border.all(color: Colors.grey, width: 0.5),
//   ),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Text(
//         "Actividad",
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey,
//         ),
//       ),
//       Text(
//         "Encuestas",
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey,
//         ),
//       ),
//       Text(
//         "Discusiones",
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey,
//         ),
//       )
//     ],
//   ),
// ),
