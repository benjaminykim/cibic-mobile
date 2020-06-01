import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class UserProfileScreen extends StatefulWidget {
  final int idUser;

  UserProfileScreen(this.idUser);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  String followButtonText = "seguir";
  Color followButtonColor = Colors.green;

  ProfileViewModel generateForeignProfileViewModel(
      Store<AppState> store, int idUser) {
    Function refreshFeed =
        () {
          store.dispatch(FetchProfileAttempt(idUser, "foreignUser"));
          store.dispatch(FetchProfileFeedAttempt(idUser, "foreignUser"));
        };
    FeedModel userFeed;
    UserModel user;
    bool error;
    String jwt;

    user = store.state.profile['foreignUser'];
    userFeed = store.state.feeds['foreignUser'];
    error = store.state.feedState['foreignUserIsError'];
    jwt = store.state.user['jwt'];

    Function onPop = () => store.dispatch(ClearProfile("foreignUser"));
    Function onReact = (ActivityModel activity, int reactValue) =>
        store.dispatch(PostReactionAttempt(activity, reactValue, 4));
    Function onSave = (int activityId) => store.dispatch(PostSaveAttempt(activityId, true));
    return ProfileViewModel(user, userFeed, refreshFeed, error, jwt, onPop, onReact, onSave);
  }

  Widget generateProfileScreen(BuildContext context, ProfileViewModel vm) {
    if (vm.error != true && vm.user != null && vm.feed != null) {
      return MaterialApp(
        theme: cibicTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(vm.user.firstName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
            centerTitle: true,
            titleSpacing: 0.0,
            leading: GestureDetector(
              onTap: () {
                vm.onPop();
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
                                      "${vm.user.firstName} ${vm.user.lastName}",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  (vm.idUser != widget.idUser)
                                      ? Container(
                                          height: 17,
                                          child: FlatButton(
                                            color: (vm.user.followers
                                                    .any((k) => k.id == vm.idUser))
                                                ? Colors.blue
                                                : Colors.green,
                                            onPressed: () async {
                                              if (this.followButtonText ==
                                                  "seguir") {
                                                String ret = await followUser(
                                                    widget.idUser, vm.jwt);
                                                if (ret != "error") {
                                                  setState(() {});
                                                }
                                              } else {
                                                setState(() {});
                                              }
                                            },
                                            child: Text(
                                                (vm.user.followers.any(
                                                        (k) => k.id == vm.idUser))
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
                              // user meta data
                              Container(
                                width: MediaQuery.of(context).size.width - 160,
                                margin: EdgeInsets.fromLTRB(10, 15, 15, 0),
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
                                            Text(
                                                vm.user.followers.length
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            Text(
                                                (vm.user.followers.length > 1)
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
                                            Text(
                                                vm.user.cabildos.length
                                                    .toString(),
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
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            return ActivityView(activity, vm.onReact, vm.onSave, FEED_FOREIGN);
                          }),
                    ))
                  ]),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Container(
          height: 50,
          width: 50,
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator()),
        ),
      );
    }
  }

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      converter: (Store<AppState> store) {
        store.dispatch(FetchProfileAttempt(widget.idUser, "foreignUser"));
        return generateForeignProfileViewModel(store, widget.idUser);
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
  int idUser;
  Function onPop;
  Function onReact;
  Function onSave;
  ProfileViewModel(this.user, this.feed, this.refresh, this.error, this.jwt,
      this.onPop, this.onReact, this.onSave) {
    this.idUser = extractID(jwt);
  }
}
