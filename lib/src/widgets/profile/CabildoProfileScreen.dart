import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:cibic_mobile/src/widgets/menu/loading.dart';
import 'package:flutter/material.dart';

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
  int maxLines;
  Future<CabildoModel> cabildoProfile;
  Future<FeedModel> cabildoFeed;
  FeedModel loadedFeed;
  double profileHeight;
  bool isFollowing;
  bool isLoaded;
  ScrollController controller;

  @override
  initState() {
    super.initState();
    this.maxLines = 4;
    this.profileHeight = 160;
    this.isFollowing = false;
    this.isLoaded = false;
    this.loadedFeed = FeedModel.initial();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  refresh(String jwt) async {
    this.loadedFeed = FeedModel.initial();
    this.cabildoFeed = fetchCabildoFeed(jwt, widget.idCabildo.toString(), 0);
    return null;
  }

  Future<CabildoModel> fetchCabildoProfile(String jwt, String id) async {
    String url = API_BASE + ENDPOINT_CABILDO_PROFILE + id;

    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $jwt"
    });

    printResponse("CABILDO PROFILE", "GET", response.statusCode);
    if (response.statusCode == 200) {
      return CabildoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load Cabildo Profile ${response.statusCode.toString()}');
    }
  }

  Future<FeedModel> fetchCabildoFeed(String jwt, String id, int offset) async {
    String url =
        API_BASE + ENDPOINT_CABILDO_FEED + id + "/" + offset.toString();

    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $jwt"
    });

    printResponse("CABILDO FEED", "GET", response.statusCode);
    if (response.statusCode == 200) {
      if (offset != 0) {
        FeedModel returnFeed =
            FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
        setState(() {
          this.loadedFeed.feed.addAll(returnFeed.feed);
        });
        return this.loadedFeed;
      } else {
        FeedModel returnFeed =
            FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
        setState(() {
          this.loadedFeed = returnFeed;
        });
        return this.loadedFeed;
      }
    } else {
      throw Exception(
          'Failed to load Cabildo Feed ${response.statusCode.toString()}');
    }
  }

  Future<bool> followCabildo(String jwt, int cabildoId, bool follow) async {
    String url = API_BASE;
    if (follow) {
      url += ENDPOINT_FOLLOW_CABILDO;
    } else {
      url += ENDPOINT_UNFOLLOW_CABILDO;
    }
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode({"cabildoId": cabildoId})));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printResponse((follow) ? "CABILDO FOLLOW" : "CABILDO UNFOLLOW", "POST",
        response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  _CabildoViewModel generateCabildoViewModel(
      Store<AppState> store, int idUser) {
    String jwt = store.state.user['jwt'];
    if (this.isLoaded == false) {
      this.cabildoProfile =
          fetchCabildoProfile(jwt, widget.idCabildo.toString());
      this.cabildoFeed = fetchCabildoFeed(jwt, widget.idCabildo.toString(), 0);
      this.isLoaded = true;
    }

    Function onReact = (ActivityModel activity, int reactValue) =>
        store.dispatch(PostReactionAttempt(activity, reactValue, 3));
    Function onSave =
        (int activityId) => store.dispatch(PostSaveAttempt(activityId, true));
    void _scrollListener() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        this.cabildoFeed = fetchCabildoFeed(
            jwt, widget.idCabildo.toString(), this.loadedFeed.feed.length);
      }
    }

    controller = new ScrollController()..addListener(_scrollListener);
    return _CabildoViewModel(
      jwt,
      onReact,
      onSave,
      controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CabildoViewModel>(
      converter: (Store<AppState> store) {
        return generateCabildoViewModel(store, widget.idCabildo);
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
                        if (snapshot.hasData) {
                          CabildoModel cabildo = snapshot.data;
                          this.isFollowing =
                              cabildo.members.any((k) => k.id == vm.userId);
                          return Container(
                            height: this.profileHeight,
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
                                            cabildo.name,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                                              color: Color(0xff43a1bf),
                                              onPressed: () async {
                                                if ((cabildo.members.any((k) =>
                                                    k.id == vm.userId))) {
                                                  bool success =
                                                      await followCabildo(
                                                          vm.jwt,
                                                          widget.idCabildo,
                                                          false);
                                                  if (success) {
                                                    setState(() {
                                                      this.isFollowing = false;
                                                      Function condition =
                                                          (UserModel user) {
                                                        return user.id ==
                                                            vm.userId;
                                                      };
                                                      cabildo.members
                                                          .removeWhere(
                                                              condition);
                                                    });
                                                  }
                                                } else {
                                                  bool success =
                                                      await followCabildo(
                                                          vm.jwt,
                                                          widget.idCabildo,
                                                          true);
                                                  if (success) {
                                                    setState(() {
                                                      this.isFollowing = true;
                                                      cabildo.members.add(
                                                          UserModel.fromUserId(
                                                              vm.userId));
                                                    });
                                                  }
                                                }
                                              },
                                              child: Text(
                                                  (((cabildo.members.any((k) =>
                                                              k.id ==
                                                              vm.userId) &&
                                                          this.isFollowing)
                                                      ? "siguiendo"
                                                      : "seguir")),
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
                                                      cabildo.members.length
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                  Text(
                                                      (cabildo.members.length >
                                                                  1 ||
                                                              cabildo.members
                                                                      .length ==
                                                                  0)
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
                        } else if (snapshot.hasError) {
                          return Container(
                            height: this.profileHeight,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Text(
                              "Profile could not be reached, Cibic server is down",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        } else {
                          return Container(
                            height: this.profileHeight,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: LoadingPiece(),
                          );
                        }
                      },
                    ),
                    // feed
                    FutureBuilder<FeedModel>(
                        future: cabildoFeed,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: RefreshIndicator(
                                onRefresh: () {
                                  return refresh(vm.jwt);
                                },
                                child: ListView.separated(
                                    controller: vm.controller,
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                          color: Colors.black,
                                        ),
                                    itemCount: this.loadedFeed.feed.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (ActivityView(
                                          this.loadedFeed.feed[index],
                                          vm.onReact,
                                          vm.onSave,
                                          4));
                                    }),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Container(),
                            );
                          }
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
  ScrollController controller;
  _CabildoViewModel(this.jwt, this.onReact, this.onSave, this.controller) {
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
