import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:cibic_mobile/src/widgets/menu/loading.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends StatefulWidget {
  final int idUser;

  UserProfileScreen(this.idUser);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  Future<UserModel> userProfile;
  Future<FeedModel> userFeed;
  double profileHeight;
  bool isFollowing;
  bool isLoaded;

  @override
  initState() {
    super.initState();
    this.maxLines = 4;
    this.profileHeight = 160;
    this.isFollowing = false;
    this.isLoaded = false;
  }

  _ProfileViewModel generateForeignProfileViewModel(
      Store<AppState> store, int idUser) {
    String jwt = store.state.user['jwt'];

    Function onReact = (ActivityModel activity, int reactValue) =>
        store.dispatch(PostReactionAttempt(activity, reactValue, 4));
    Function onSave =
        (int activityId) => store.dispatch(PostSaveAttempt(activityId, true));
    if (this.isLoaded == false) {
      this.userProfile = fetchProfile(jwt, widget.idUser.toString());
      this.userFeed = fetchProfileFeed(jwt, widget.idUser.toString());
      this.isLoaded = true;
    }
    return _ProfileViewModel(jwt, onReact, onSave);
  }

  Widget generateProfileScreen(BuildContext context, _ProfileViewModel vm) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("USUARIO",
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
        body: Center(
          child: Container(
            color: APP_BACKGROUND,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // PROFILE INFO WIDGET
                  FutureBuilder<UserModel>(
                    future: userProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserModel user = snapshot.data;
                        this.isFollowing =
                            user.followers.any((k) => k.id == vm.id);
                        return Container(
                          height: this.profileHeight,
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
                                          "${user.firstName} ${user.lastName}",
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
                                      (vm.id != widget.idUser)
                                          ? Container(
                                              height: 17,
                                              child: FlatButton(
                                                color: Color(0xff43a1bf),
                                                onPressed: () async {
                                                  if ((user.followers.any(
                                                      (k) => k.id == vm.id))) {
                                                    bool success =
                                                        await followUser(
                                                            vm.jwt,
                                                            widget.idUser,
                                                            false);
                                                    if (success) {
                                                      setState(() {
                                                        this.isFollowing =
                                                            false;
                                                        Function condition =
                                                            (UserModel user) {
                                                          return user.id ==
                                                              vm.id;
                                                        };
                                                        user.followers
                                                            .removeWhere(
                                                                condition);
                                                      });
                                                    }
                                                  } else {
                                                    bool success =
                                                        await followUser(
                                                            vm.jwt,
                                                            widget.idUser,
                                                            true);
                                                    if (success) {
                                                      setState(() {
                                                        this.isFollowing = true;
                                                        user.followers.add(
                                                            UserModel
                                                                .fromUserId(
                                                                    vm.id));
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                    (user.followers.any((k) =>
                                                            k.id == vm.id &&
                                                            this.isFollowing))
                                                        ? "siguiendo"
                                                        : "seguir",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    )),
                                              ))
                                          : Container(),
                                    ],
                                  ),
                                  // USER METADATA
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 160,
                                    margin: EdgeInsets.fromLTRB(10, 15, 15, 0),
                                    child: Column(
                                      children: [
                                        // CITIZEN POINTS, FOLLOWERS AND CABILDOS
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Icon(Icons.offline_bolt),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  user.citizenPoints.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ]),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            // FOLLOWERS
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                    user.followers.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                Text(
                                                    (user.followers.length >
                                                                1 ||
                                                            user.followers
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
                                              width: 20,
                                            ),
                                            // CABILDOS
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                    user.cabildos.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    )),
                                                Text(
                                                    (user.cabildos.length > 1)
                                                        ? "cabildos"
                                                        : "cabildo",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(width: 10),
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
                                                    user.desc ?? "",
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
                            border: Border.all(color: Colors.grey, width: 0.5),
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
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: LoadingPiece(),
                        );
                      }
                    },
                  ),
                  // feed
                  FutureBuilder<FeedModel>(
                      future: userFeed,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
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
                                      4));
                                }),
                          );
                        } else {
                          return Expanded(
                            child: Container(),
                          );
                        }
                      }),
                ]),
          ),
        ),
      ),
    );
  }

  Future<UserModel> fetchProfile(String jwt, String id) async {
    String url = API_BASE + ENDPOINT_USER + id;
    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $jwt"
    });

    print("fetchProfile id:$id    response:${response.statusCode}");
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          "Failed to load User Profile ${response.statusCode.toString()}");
    }
  }

  Future<FeedModel> fetchProfileFeed(String jwt, String id) async {
    String url = API_BASE + ENDPOINT_USER_FEED + id;

    final response = await http.get(url, headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer $jwt"
    });

    print("fetchFeed id:$id    response:${response.statusCode}");
    if (response.statusCode == 200) {
      return FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    } else {
      throw Exception(
          "Failed to load User Feed ${response.statusCode.toString()}");
    }
  }

  Future<bool> followUser(String jwt, int idUserFollow, bool follow) async {
    String url = API_BASE;
    if (follow) {
      url += ENDPOINT_FOLLOW_USER;
    } else {
      url += ENDPOINT_UNFOLLOW_USER;
    }
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode({"userId": idUserFollow})));
    HttpClientResponse response = await request.close();
    httpClient.close();

    print("DEBUG: ${(follow) ? 'follow' : 'unfollow'} user ");
    print("     response: ${response.statusCode.toString()}");
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ProfileViewModel>(
      converter: (Store<AppState> store) {
        return generateForeignProfileViewModel(store, widget.idUser);
      },
      builder: (BuildContext context, _ProfileViewModel vm) {
        return generateProfileScreen(context, vm);
      },
    );
  }
}

class _ProfileViewModel {
  String jwt;
  int id;
  Function onReact;
  Function onSave;
  _ProfileViewModel(this.jwt, this.onReact, this.onSave) {
    this.id = extractID(jwt);
  }
}

// feed button bar
// Container(
//     margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//     padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
//     height: 40,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       border:
//           Border.all(color: Colors.grey, width: 0.5),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "Actividad",
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//         Text(
//           "Encuestas",
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//         Text(
//           "Discusiones",
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         )
//       ],
//     ))
