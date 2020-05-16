import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SelfProfileScreen extends StatefulWidget {
  SelfProfileScreen();

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<SelfProfileScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  String followButtonText = "seguir";
  Color followButtonColor = Colors.green;

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  ProfileViewModel generateProfileViewModel(Store<AppState> store) {
    Function refreshFeed = () => store.dispatch(FetchUserProfileAttempt);
    FeedModel userFeed;
    UserModel user;
    bool error;
    String jwt;

    user = store.state.user;
    userFeed = store.state.userProfileFeed;
    error = store.state.userProfileError;
    jwt = store.state.jwt;
    return ProfileViewModel(user, userFeed, refreshFeed, error, jwt);
  }

  Widget generateProfileScreen(BuildContext context, ProfileViewModel vm) {
    if (vm.error != true && vm.user != null && vm.feed != null) {
      return Center(
        child: Container(
          color: APP_BACKGROUND,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.5),
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
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          // name
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
                            width: 120,
                            child: Text(
                              vm.user.username,
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
                        width: MediaQuery.of(context).size.width - 160,
                        margin: EdgeInsets.fromLTRB(10, 15, 15, 0),
                        child: Column(
                          children: [
                            // citizen points, followers, cabildos following
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // citizen points
                                Row(children: [
                                  Icon(Icons.offline_bolt),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(vm.user.citizenPoints.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                ]),
                                // followers
                                Column(
                                  children: <Widget>[
                                    Text(vm.user.followers.length.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text(
                                        (vm.user.cabildos.length > 1)
                                            ? "seguidores"
                                            : "seguidor",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                                // cabildos
                                Column(
                                  children: <Widget>[
                                    Text(vm.user.cabildos.length.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )),
                                    Text(
                                        (vm.user.cabildos.length > 1)
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
                                        vm.user.desc ?? "",
                                        maxLines: this.maxLines,
                                        overflow: TextOverflow.ellipsis,
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
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
            ),
            // feed
            Expanded(
                child: RefreshIndicator(
              key: refreshKey,
              onRefresh: () => vm.refresh(),
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                  itemCount: vm.feed.feed.length,
                  itemBuilder: (BuildContext context, int index) {
                    ActivityModel activity = vm.feed.feed[index];
                    return ActivityView(activity, vm.jwt);
                  }),
            ))
          ]),
        ),
      );
    } else {
      return Text("Profile could not be reached, Cibic server is down",
          textAlign: TextAlign.center, style: TextStyle(color: Colors.black));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      converter: (Store<AppState> store) {
        return generateProfileViewModel(store);
      },
      builder: (BuildContext context, ProfileViewModel vm) {
        return generateProfileScreen(context, vm);
      },
    );
  }
}

class ProfileViewModel {
  UserModel user;
  FeedModel feed;
  Function refresh;
  bool error;
  String jwt;
  ProfileViewModel(this.user, this.feed, this.refresh, this.error, this.jwt);
}
