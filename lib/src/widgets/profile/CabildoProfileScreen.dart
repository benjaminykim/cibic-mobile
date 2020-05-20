import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CabildoProfileScreen extends StatefulWidget {
  final String idCabildo;

  CabildoProfileScreen(this.idCabildo);

  @override
  _CabildoProfileState createState() => _CabildoProfileState();
}

class _CabildoProfileState extends State<CabildoProfileScreen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int maxLines = 4;
  String followButtonText = "seguir";
  Color followButtonColor = Colors.green;

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  void refreshList() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CabildoViewModel>(
      converter: (Store<AppState> store) {
        store.dispatch(FetchCabildoProfileAttempt(widget.idCabildo));
        return _CabildoViewModel(store);
      },
      builder: (BuildContext context, _CabildoViewModel vm) {
        if (vm.cabildo == null) {
          return CircularProgressIndicator();
        } else if (vm.isError) {
          return Text("is error", style: TextStyle(color: Colors.white));
        } else {
          return MaterialApp(
            theme: cibicTheme,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text(vm.name,
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
              body: Container(
                color: APP_BACKGROUND,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // PROFILE INFO WIDGET
                      Container(
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
                                        vm.name,
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
                                          color: (vm.members.any(
                                                  (k) => k['_id'] == vm.idUser))
                                              ? Colors.blue
                                              : Colors.green,
                                          onPressed: () async {
                                            if (this.followButtonText ==
                                                "seguir") {
                                              String ret = await followCabildo(
                                                  widget.idCabildo, vm.jwt);
                                              if (ret != "error") {
                                                setState(() {
                                                  vm.members
                                                      .add({'_id': vm.idUser});
                                                  this.followButtonText =
                                                      "siguiendo";
                                                });
                                              }
                                            } else {
                                              String ret =
                                                  await unfollowCabildo(
                                                      widget.idCabildo, vm.jwt);
                                              if (ret != "error") {
                                                setState(() {
                                                  vm.members.removeAt(vm.members
                                                      .indexWhere((k) =>
                                                          k['_id'] ==
                                                          vm.idUser));
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
                                              Text(vm.members.length.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              Text(
                                                  (vm.members.length > 1)
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
                                            Text(vm.location,
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
                                                  vm.description,
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
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                            itemCount: vm.feed.feed.length,
                            itemBuilder: (BuildContext context, int index) {
                              return (ActivityView(
                                  vm.feed.feed[index], vm.jwt));
                            }),
                      )
                    ]),
              ),
            ),
          );
        }
      },
    );
  }
}

class _CabildoViewModel {
  String idUser;
  String jwt;
  String name;
  String description;
  String location;
  FeedModel feed;
  List<Map<String, String>> members;
  bool isError;
  bool isLoading;
  Function onPop;
  CabildoModel cabildo;
  _CabildoViewModel(store) {
    this.jwt = store.state.jwt;
    this.idUser = store.state.idUser;
    this.isError = store.state.cabildoProfileError;
    this.onPop = () => store.dispatch(FetchCabildoProfileClear());
    if (store.state.cabildoProfile != null) {
      this.cabildo = store.state.cabildoProfile;
      this.name = store.state.cabildoProfile.name;
      this.description = store.state.cabildoProfile.desc;
      this.location = store.state.cabildoProfile.location;
      this.members = store.state.cabildoProfile.members;
      this.feed = store.state.cabildoProfileFeed;
      this.isLoading = false;
    } else {
      this.isLoading = true;
      this.cabildo = null;
      this.name = "null";
      this.description = "null";
      this.location = "null";
      this.members = [];
      this.feed = FeedModel([]);
    }
  }
}
